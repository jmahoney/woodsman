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
  
  
  
  
  
  
end
