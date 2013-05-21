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
    dt = Time.zone.now
    newdt = Time.zone.today + 30
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
    
    dt = Time.zone.now
    Timecop.freeze(dt) do
      p = Post.new(:title => "Test", :content => "more content")
      p.save
      assert_equal "test#{dt.strftime('-%H%M%S')}", p.slug, "slug is not what we expect to be generated"
    end 
  end

  test "converts string into a list of tags" do
    p = Post.new(:title => "Test", :content => "content")
    p.tag_list = "tag1, tag2, tag3"
    assert_equal ["tag1","tag2", "tag3"], p.tags
  end
  
  test "removes redundant tags from list" do
    p = Post.new(:title => "Test", :content => "content")
    p.tag_list = "tag1, tag2, tag3, tag3, tag3"
    assert_equal ["tag1","tag2", "tag3"], p.tags
  end
  
  test "returns tags as a comma delimited string" do
    p = Post.new
    p.tags = ["tag1", "tag2", "tag3"]
    assert_equal "tag1, tag2, tag3", p.tag_list
  end
  
  test "can find a post with a certain tag" do
    Post.create(:title => "With tag", :content => "content", :tag_list => 'tag1, tag2, tag3')
    Post.create(:title => "Without tag", :content => "content", :tag_list => 'tag1, tag2')
    
    posts = Post.tagged("tag3")
    assert_equal 1, posts.size
    assert_equal "With tag", posts.first.title    
  end
  
  test "uses published date and slug as param" do
    Timecop.freeze do
      p = Post.create(:title => 'Testing To Param', :content => 'foo')
      assert_equal "#{Time.zone.now.strftime('%Y/%m')}/testing-to-param", p.to_param
      assert_equal "#{Time.now.strftime('%Y/%m')}/testing-to-param", p.to_param
    end
  end
  
  test "returns published posts" do
    posts = Post.published
    assert_equal 3, posts.size
  end
  
  test "returns posts in chronological order of publishing" do
    posts = Post.published.archive_order
    assert_equal "Live One", posts.first.title
    assert_equal "Live Three", posts.last.title
  end
  
  test "returns posts in reverse-chronological order of publishing" do
    posts = Post.published.blog_order
    assert_equal "Live Three", posts.first.title
    assert_equal "Live One", posts.last.title
  end
  
  test "returns published posts for a specfied year and month" do
    posts = Post.month(2013,1)
    assert_equal 2, posts.size
  end
  
  test "returns an array containing links to year and month archive links" do
    archive = Post.archive
    assert_equal 2, archive.length
    assert_equal 3, archive.first.month
    assert_equal 1, archive.last.month
    assert_equal 2013, archive.first.year
    assert_equal 2, archive.last.post_count
  end
  
  
  test "returns an array containing links to tag archive links" do
    tag_archive = Post.tag_archive
    assert_equal 4, tag_archive.length
    assert_equal 'foo', tag_archive.first.tag
    assert_equal 3, tag_archive.first.post_count
  end
  
end
