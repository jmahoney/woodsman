require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  def test_access_granted_for_posts_index
    get "/posts"
    assert_equal 200, status
  end
  
  def test_access_denied_for_editing_methods
    get "/admin/posts/new"
    assert_equal 401, status
    
    get "/admin/posts/1/edit"
    assert_equal 401, status
    
    post "/admin/posts"
    assert_equal 401, status
    
    patch "/admin/posts/1"
    assert_equal 401, status
    
    delete "/admin/posts/1"
    assert_equal 401, status
  end
  
  def test_can_edit_with_appropriate_credentials    
    get "/admin/posts/new", {}, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(ENV['WOODSMAN_USER'],ENV['WOODSMAN_PASSWORD'])
    assert_equal 200, status  
  end
end
