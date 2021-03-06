require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    request.env['HTTP_AUTHORIZATION'] = 
      ActionController::HttpAuthentication::Basic.encode_credentials(ENV['WOODSMAN_USER'],ENV['WOODSMAN_PASSWORD'])
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end
  
  test "should use admin layout" do
    get :index
    assert_template layout: "layouts/admin"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { content: @post.content, published_at: @post.published_at, status: @post.status, title: @post.title }
    end

    assert_redirected_to admin_posts_path
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { content: @post.content, published_at: @post.published_at, status: @post.status, title: @post.title }
    assert_redirected_to admin_posts_path
  end

  test "should publish post" do
    patch :publish, id: @post
    assert_redirected_to admin_posts_path
  end
  
  test "should withdraw post" do
    patch :withdraw, id: @post
    assert_redirected_to admin_posts_path
  end
  

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to admin_posts_path
  end



end
