require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "post has draft status by default" do
    assert_equal('draft', Post.new.status)
  end
  
  test "requires title, content" do
    p = Post.new
    assert !p.save
    
    p.title = "foo"
    assert !p.save
    
    p.content = "bar"
    assert p.save
  end

  test "sets published date to be current/date on create if not popluated" do
    dt = DateTime.now
    newdt = Date.today + 30
    Timecop.freeze(dt) do
      p = Post.new(:title => "title", :content => "content")
      p.save
      assert_equal p.published_at.strftime("%Y%m%d%H%M%S"), dt.strftime("%Y%m%d%H%M%S")      
      p = Post.new(:title => 'newer', :content => "content", :published_at => newdt)      
      p.save
      assert_equal newdt.strftime("%Y%m%d%H%M%S"), p.published_at.strftime("%Y%m%d%H%M%S")
    end
    
    
  end  
  
  test "generates a slug based on title" do
    p = Post.new(:title => 'Testing auto-generation of slugs', :content => 'content')
    p.save
    assert_equal "testing-auto-generation-of-slugs", p.slug, "slugs do not match"
  end
  
  test "tries to create a unique slug" do
    p = Post.new(:title => "Test", :content => "content")
    p.save
    
    dt = DateTime.now
    Timecop.freeze(dt) do
      p = Post.new(:title => "Test", :content => "more content")
      p.save
      assert_equal "test#{dt.strftime('-%H%M%S')}", p.slug, "slug is not what we expect to be generated"
    end 
  end
  
  
end
