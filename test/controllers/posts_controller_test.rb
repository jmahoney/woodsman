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
    get :archive
    assert_response :success
    assert_not_nil assigns(:archive)
    assert_not_nil assigns(:tag_archive)
  end
  
  test "should show monthly archive page" do
    get :month, {month: 01, year: 2013}
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_not_nil assigns(:year)
    assert_not_nil assigns(:month)
  end

end
