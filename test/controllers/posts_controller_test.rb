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
  
  test "should use posts layout" do
    get :show, id: @post
    assert_template layout: "layouts/posts"
  end
  
  test "should show archive page" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)  
  end
  
  # test "should provide atom feed" do
  #   get :feed, format: :xml
  #   assert_response :success
  #   assert_not_nil assigns(:posts)
  # end

end
