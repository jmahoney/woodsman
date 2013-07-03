require "test_helper"
require 'capybara/poltergeist'
require 'capybara/rails'
include Capybara::DSL
Capybara.javascript_driver = :poltergeist

class HomeTest < ActionDispatch::IntegrationTest
  
  test "should see title on home page" do
    visit "/"
    assert page.has_title?(I18n.t('home.html_title'))
  end
  
  test "should see links to home and archive" do
    visit "/"
    assert page.has_link? "Home"  #why doesn't I18n work here?
    assert page.has_link? "Archive"
  end
  
  
end
