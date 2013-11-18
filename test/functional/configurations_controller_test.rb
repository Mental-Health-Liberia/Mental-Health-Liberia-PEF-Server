require 'test_helper'

class ConfigurationsControllerTest < ActionController::TestCase
  test "should create with only format parameter" do
    user = FactoryGirl.create(:user, write_api: true)
    sign_in :user, user

    post(:create, {:format => "json"})
    assert_response :success, @response.body

    body = @response.body
    assert_nil body['format']
    assert_nil body['controller']
    assert_nil body['action']
  end

  test "should show no configurations if no configurations exist" do
    user = FactoryGirl.create(:user, read_api: true)
    sign_in :user, user

    get(:index, {:format => "json"})

    assert_response :success, @response.body
  end
end
