class Cpanel::PostsController < Cpanel::ApplicationController
  
  before_filter :add_common_breadcrumb, :except => [:index]
  
  def index
    set_page_tags(t("cpanel.pages.posts.index"))
    @posts = Post.latest.page(params[:page]).per(Setting.cpanel_page_size)
  end
  
  def show
    @post = Post.find params[:id]
    impressionist(@post)
  end
  
  def new
    set_page_tags(t("cpanel.pages.posts.new"))
    @post = Post.new
  end
  
  def create
    set_page_tags(t("cpanel.pages.posts.new"))
		@post = Post.new params[:post]
		if @post.save
			redirect_to cpanel_posts_path, :notice => t("cpanel.messages.success")
		else
			render :new
		end
  end
  
  def edit
    set_page_tags(t("cpanel.pages.posts.edit"))
    @post = Post.find params[:id]
  end
  
  def update
    set_page_tags(t("cpanel.pages.posts.edit"))
		@post = Post.find params[:id]
		if @post.update_attributes params[:post]
			redirect_to cpanel_posts_path, :notice => t("cpanel.messages.success")
    else
    	render :edit
    end
  end
  
  def destroy
    @post = Post.find params[:id]
		if @post.destroy
			redirect_to cpanel_posts_path, :notice => t("cpanel.messages.success")
		else
			redirect_to cpanel_posts_path, :alert => t("cpanel.messages.error")
		end
  end
  
  def destroies
		if params[:post_ids].blank?
			return redirect_to cpanel_posts_path, :alert => t("cpanel.messages.select_empty")
		end
		if Post.destroy_all(:_id.in => params[:post_ids])
			redirect_to cpanel_posts_path, :notice => t("cpanel.messages.success")
		else
			redirect_to cpanel_posts_path, :alert => t("cpanel.messages.error")
		end
  end
  
  def search
    set_page_tags(t("cpanel.pages.posts.search"))
    @posts = Post.search(params[:q]).page(params[:page]).per(Setting.cpanel_page_size)
    @query = params[:q]
    render :index
  end
  
	private
	def add_common_breadcrumb
		add_breadcrumb(t("cpanel.pages.posts.index"), cpanel_posts_path)
	end
  
end
