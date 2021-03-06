module PostsHelper
  # create a link to a particular year/month in the blog archive
  def month_archive_link(item)
    url = "/#{item.year.to_i}/#{sprintf('%02d',item.month.to_i)}"
    link_text = "#{Date::MONTHNAMES[item.month]}, #{item.year.to_i}"
    title_text = "#{item.post_count} #{posts_str(item.post_count)} in #{link_text}"
    link_to(link_text, url, {title: title_text})
  end
  
  def tag_archive_link(item)
    url = "/tagged/#{item.tag}"
    title_text = "#{item.post_count} #{posts_str(item.post_count)} in #{item.tag}"
    link_to(item.tag, url, {title: title_text})
  end
  
  def list_separator(total, current)
    " • " if current < total
  end
  
  def render_intro_and_content(post)
    str = ""
    str += image_tag(post.image.image.post_width.url, alt: post.image.title)  unless post.image.blank?
    str += "#{@markdown.render(post.intro).html_safe}" unless post.intro.blank?
    str += "#{@markdown.render(post.content).html_safe}" unless post.content.blank?
    str
  end
  
  private 
  
  #should we show "posts" or "post"? 
  def posts_str(post_count)
    post_count == 1 ? "post" : "posts"
  end
end
