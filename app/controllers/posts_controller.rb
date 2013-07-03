class PostsController < ApplicationController
  include Markdownable
  
  layout "posts"
  respond_to :html
  before_action :set_post, only: [:show]
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  # GET /posts/1
  def show
  end

  def archive
    @archive = Post.published.archive_order
    @tag_archive = Post.tag_archive
  end
  
  def month
    @year = params[:year].to_i
    @month = params[:month].to_i
    @posts = Post.archive_order.month(@year, @month)
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
