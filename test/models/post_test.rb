require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "post has draft status by default" do
    assert_equal('draft', Post.new.status)
  end
  
  test "requires title, content, published_at" do
    p = Post.new
    assert !p.save
    
    p.title = "foo"
    assert !p.save
    
    p.content = "bar"
    assert !p.save
    
    p.published_at = DateTime.now
    assert p.save
  end
  
  test "creates slug from title when slug is blank" do
    p = Post.new(:title => 'This is my post', :content => 'bar', :published_at => DateTime.now)
    p.save
    assert_equal("this-is-my-post", p.slug, "generated slug is incorrect")
  end
  
  test "does not automagically create slug when already populated" do
    p = Post.new(:title => 'This is my post', :content => 'bar', :slug => 'test-post', :published_at => DateTime.now)
    p.save
    assert_equal("test-post", p.slug, "found a generated slug when a manual one was specified")
  end
  
  
  
  
  
end
