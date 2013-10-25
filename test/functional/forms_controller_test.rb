require 'test_helper'

class FormsControllerTest < ActionController::TestCase
  test "should not create with no parameters" do
    post(:create,  {})
    assert_response 406, @response.body
  end

  test "should create with only format parameter" do
    post(:create,  {:format => "json"})
    assert_response :success, @response.body

    body = @response.body
    assert_nil body['format']
    assert_nil body['controller']
    assert_nil body['action']
  end
end
