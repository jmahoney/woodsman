require "test_helper"

class PostsTest < ActionDispatch::IntegrationTest
  test "should get a specific post" do
    get "2013/01/live-one"
    assert_equal 200, status
  end
  
  test "should throw 404 if a post doesn't exist" do
    get "2000/01/foo"
    assert_equal 404, status
  end
  
  test "should throw 404 if a post exists but is not published" do
    get "2013/01/draft-one"
    assert_equal 404, status
  end
  
  test "should show an archive page" do
    get "/archive"
    assert_equal 200, status
  end  
  
  test "should redirect to the the archive page for a year url" do    
    get "/2013" 
    assert_equal 301, status
  end
  
  test "should ask for a specific month of posts" do
    get "/2013/01"
    assert_equal 200, status
  end
  
  
  
  test "should return 404 if no posts in a specific month" do
    get "/2000/01"  
    assert_equal 404, status
  end
  
  
end
