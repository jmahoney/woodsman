xml.instruct!
xml.urlset("xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  # home
  xml.url do
    xml.loc(root_url)
  end
  
  #archive
  xml.url do
    xml.loc(archive_url)
  end
  
  #feed
  xml.url do
    xml.loc(feed_posts_url)
  end
  
  #public key
  xml.url do
    xml.loc(public_key_url)
  end
  
  #posts
  @posts.each do |post|
    xml.url do
      xml.loc(post_url(post))
    end
  end
  
end