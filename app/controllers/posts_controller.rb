class PostsController < ApplicationController
  layout "posts"
  respond_to :html
  before_action :set_post, only: [:show]
  before_action :set_markdown_renderer
  
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
  
  # set up a renderer that the views can use to render markdown
  # stored in i18n files and post content
  def set_markdown_renderer
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
                    :autolink => true, 
                    :disable_indented_code_blocks => true,
                    :fenced_code_blocks => true,
                    :lax_spacing => true,
                    :no_intra_emphasis => true,
                    :space_after_headers => true,
                    :tables => true)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.published.find_by!(date_slug: "#{params[:id]}")
  end
  
  def not_found
    render nothing: true, status: 404
  end

end
