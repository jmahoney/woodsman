require 'test_helper'

class Admin::ImagesControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Basic.encode_credentials(ENV['WOODSMAN_USER'],ENV['WOODSMAN_PASSWORD'])
  end
  
  test "should get selector" do
    get "selector"
    assert_response :success
  end
  
  test "should use selector layout" do
    get "selector"
    assert_template layout: "layouts/selector"
  end
end
