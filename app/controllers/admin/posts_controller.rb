class Admin::PostsController < Admin::AdminController
  include Markdownable
  respond_to :html
  layout "admin"
  
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :withdraw]
  
  

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    @posts = Post.all.blog_order
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
    set_markdown_renderer
    render :layout => 'posts'
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.' 
    else
      render action: 'new' 
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      render action: 'edit' 
    end
  end
  
  def publish
    if @post.publish!
      redirect_to admin_posts_path, notice: t('admin.published')
    else
      redirect_to admin_posts_path, notice: t('admin.not_published')
    end
  end
  
  def withdraw
    if @post.withdraw!
      redirect_to admin_posts_path, notice: t('admin.withdrawn')
    else
      redirect_to admin_posts_path, notice: t('admin.not_withdrawn')
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @post.destroy

    redirect_to admin_posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(date_slug: "#{params[:id]}")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :published_at, :status, :tag_list, 
                                   :slug, :intro, :meta_tags, :meta_description, :html_title,
                                   :archive_intro)
    end
  
end
