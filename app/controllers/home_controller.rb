class HomeController < ApplicationController
  layout "posts"
  include Markdownable
  
  def show
    @posts = Post.published.blog_order.limit(3)
  end
  
end