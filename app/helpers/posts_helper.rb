module PostsHelper
  # create a link to a particular year/month in the blog archive
  def month_archive_link(item)
    url = "/#{item.year.to_i}/#{item.month.to_i}"
    link_text = "#{Date::MONTHNAMES[item.month]}, #{item.year.to_i}"
    link_to(link_text, url)
  end
end
