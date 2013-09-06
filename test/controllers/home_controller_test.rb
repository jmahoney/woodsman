require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  test "get index" do
    get :show
    assert_response :success
  end
  
  test "get public key" do
    get :public_key
    assert_response :success  
  end
  
end