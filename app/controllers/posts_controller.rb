class PostsController < ApplicationController
  include Markdownable
  
  layout "posts"
  before_action :set_post, only: [:show]
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  # GET /posts/1
  def show
  end

  def archive
    @archive = Post.published.archive_order
  end
  
  def feed
    @posts = Post.published.blog_order.limit(10)
  end  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.published.find_by!(date_slug: "#{params[:id]}")
  end
  
  def not_found
    render nothing: true, status: 404
  end

end
