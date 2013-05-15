class PostsController < ApplicationController
  layout "posts"
  respond_to :html
  before_action :set_post, only: [:show]
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  # GET /posts/1
  def show
  end

  def archive
    
  end
  
  def month
    @posts = Post.archive_order.month(params[:year].to_i, params[:month].to_i)
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
