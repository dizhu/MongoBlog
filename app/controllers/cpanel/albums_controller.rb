class Cpanel::AlbumsController < Cpanel::ApplicationController
  
  before_filter :add_common_breadcrumb, :except => [:index]
  
  def index
    set_page_tags(t("cpanel.pages.albums.index"))
    @albums = Album.latest.page(params[:page]).per(Setting.cpanel_album_page_size)
  end
  
  def show
  end
  
  def new
    @album = Album.new
  end
  
  def create
		@album = Album.new params[:album]
    if @album.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end
  
  def edit
    @album = Album.find params[:id]
  end
  
  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end
  
  def destroy
    @album = Album.find params[:id]
    if @album.destroy
      redirect_to cpanel_albums_path, :notice => t("cpanel.messages.success")
    else
      redirect_to cpanel_albums_path, :notice => t("cpanel.messages.error")
    end
  end
  
  def search
    @albums = Album.search(params[:q]).page(params[:page]).per(Setting.cpanel_album_page_size)
    @query = params[:q]
    render :index
  end
  
	private
	def add_common_breadcrumb
		add_breadcrumb(t("cpanel.pages.albums.index"), cpanel_albums_path)
	end
end
