require 'test_helper'

class FormsControllerTest < ActionController::TestCase
  test "should not have access to API if not logged in" do
    get(:index, {:format => "json"})
    assert_response 302, @response.body

    post(:create, {:format => "json"})
    assert_response 302, @response.body
  end

  test "should not create with no parameters" do
    user = FactoryGirl.create(:user)
    sign_in :user, user

    post(:create,  {})
    assert_response 406, @response.body
  end

  test "should create with only format parameter" do
    user = FactoryGirl.create(:user)
    sign_in :user, user

    post(:create, {:format => "json"})
    assert_response :success, @response.body

    body = @response.body
    assert_nil body['format']
    assert_nil body['controller']
    assert_nil body['action']
  end

  test "should show no forms if no forms exist" do
    user = FactoryGirl.create(:user)
    sign_in :user, user

    get(:index, {:format => "json"})

    assert_response :success, @response.body
  end

  test "should show forms if there exist forms" do
    MongoConfig.db['forms'].insert({"name" => "tanner"})

    user = FactoryGirl.create(:user)
    sign_in :user, user

    get(:index, {:format => "json"})

    assert_response :success, @response.body
    assert_not_nil @response.body

    json = ActiveSupport::JSON.decode(@response.body)

    assert_equal json.length, 1
    assert_not_nil json[0]["_id"]
    assert_equal json[0]["name"], "tanner"
  end

  test "should show multiple forms if there exist forms" do
    MongoConfig.db['forms'].insert({"name" => "tanner"})
    MongoConfig.db['forms'].insert({"name" => "ryan"})

    user = FactoryGirl.create(:user)
    sign_in :user, user

    get(:index, {:format => "json"})

    assert_response :success, @response.body
    assert_not_nil @response.body

    json = ActiveSupport::JSON.decode(@response.body)

    assert_equal json.length, 2

    assert_not_nil json[0]["_id"]
    assert_equal json[0]["name"], "tanner"

    assert_not_nil json[1]["_id"]
    assert_equal json[1]["name"], "ryan"
  end

  test "should fail for requesting a single form with a bad id" do
    user = FactoryGirl.create(:user)
    sign_in :user, user

    get(:show, {:format => "json", "id" => 0})

    assert_response :success, @response.body

    json = ActiveSupport::JSON.decode(@response.body)

    assert_not_nil json
    assert_equal json["error"], "The given id was not a valid BSON ObjectId."
  end

  test "should fail for requesting a non-existent single form" do
    user = FactoryGirl.create(:user)
    sign_in :user, user

    get(:show, {:format => "json", "id" => "527d1e3a14b849bc70000001"})

    assert_response :success, @response.body

    json = ActiveSupport::JSON.decode(@response.body)

    assert_not_nil json["error"]
    assert_equal json["error"], "The given id was not found."
  end
end
