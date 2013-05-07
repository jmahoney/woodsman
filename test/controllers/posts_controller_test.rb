require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Basic.encode_credentials(ENV['WOODSMAN_USER'],ENV['WOODSMAN_PASSWORD'])
  end
  
  test "should show post" do
    get :show, id: @post
    assert_response :success
  end 

end
