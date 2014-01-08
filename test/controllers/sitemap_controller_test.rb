require 'test_helper'

class SitemapControllerTest < ActionController::TestCase
  test "get index" do
    get :index, format: :xml
    assert_response :success
  end
  
  test "should render xml" do
    get :index, format: :xml
    assert_template "index"
    assert_template layout: nil
  end
  
end
