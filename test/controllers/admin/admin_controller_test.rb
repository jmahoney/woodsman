require 'test_helper'

class Admin::AdminControllerTest < ActionController::TestCase
  
  setup do
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Basic.encode_credentials(ENV['WOODSMAN_USER'],ENV['WOODSMAN_PASSWORD'])
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  
end
