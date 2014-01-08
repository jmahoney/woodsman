class SitemapController < ApplicationController
  def index
    @posts = Post.published.archive_order
  end
end
