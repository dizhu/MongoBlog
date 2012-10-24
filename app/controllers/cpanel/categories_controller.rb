class Cpanel::CategoriesController < Cpanel::ApplicationController

	before_filter :add_common_breadcrumb, :except => [:index]

	def index
		set_page_tags(t("cpanel.pages.categories.index"))
		@categories = Category.latest.page(params[:page]).per(Setting.cpanel_page_size)
	end

	def new
		set_page_tags(t("cpanel.pages.categories.new"))
		@category = Category.new
	end

	def create
		set_page_tags(t("cpanel.pages.categories.new"))
		@category = Category.new params[:category]
		if @category.save
			redirect_to cpanel_categories_path, :notice => t("cpanel.messages.success")
		else
			render :new
		end
	end

	def edit
		set_page_tags(t("cpanel.pages.categories.edit"))
		@category = Category.find params[:id]
	end

	def update
		set_page_tags(t("cpanel.pages.categories.edit"))
		@category = Category.find params[:id]
		if @category.update_attributes params[:category]
			redirect_to cpanel_categories_path, :notice => t("cpanel.messages.success")
    else
    	render :edit
    end
	end

	def destroy
    @category = Category.find params[:id]
		if @category.destroy
			redirect_to cpanel_categories_path, :notice => t("cpanel.messages.success")
		else
			redirect_to cpanel_categories_path, :alert => t("cpanel.messages.error")
		end
	end
  
  def search
    set_page_tags(t("cpanel.pages.categories.search"))
    @categories = Category.search(params[:q]).page(params[:page]).per(Setting.cpanel_page_size)
    render :index
  end

	private
	def add_common_breadcrumb
		add_breadcrumb(t("cpanel.pages.categories.index"), cpanel_categories_path)
	end
	
end
