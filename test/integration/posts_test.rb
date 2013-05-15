require "test_helper"
require 'capybara/poltergeist'
require 'capybara/rails'
include Capybara::DSL
Capybara.javascript_driver = :poltergeist

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
  
  test "should redirect tumblr urls to tumblr" do
    get "/post/12345678"
    assert_equal 301, status
    
    get "/post/1234534/slug-test"
    assert_equal 301, status
  end

  test "should see title on archive page" do
    visit "/archive"
    assert page.has_title?(I18n.t('archive.html_title'))
  end
  
end
