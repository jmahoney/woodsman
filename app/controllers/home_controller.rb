class HomeController < ApplicationController
  layout "posts"
  include Markdownable
  
  def show
    @posts = Post.published.blog_order.limit(3)
  end
  
  def public_key
    render file: File.join(Rails.root, "public", "01A6FD61.asc"), 
            layout: false, content_type: "application/pgp-keys"
  end
  
end