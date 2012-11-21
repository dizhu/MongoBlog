class Cpanel::PhotosController < Cpanel::ApplicationController
  
  before_filter :get_album
  before_filter :add_common_breadcrumb, :only => [:index, :show]
  
  def index
    set_page_tags(t("cpanel.pages.photos.index"))
    @photos = @album.photos.order_by(:created_at => :desc).page(params[:page]).per(Setting.cpanel_album_page_size)
  end
  
  def show
    @photo = Photo.find params[:id]
    set_page_tags(@photo.title)
  end
  
  def new
    @photo = @album.photos.new
  end
  
  def create
    @photo = @album.photos.build params[:photo]
    @photo.save
  end
  
  def destroy
    @photo = Photo.find params[:id]
    if @photo.destroy
      redirect_to cpanel_album_photos_path(@album), :notice => t("cpanel.messages.success")
    else
      redirect_to cpanel_album_photos_path(@album), :alert => t("cpanel.messages.error")
    end
  end
  
	private
	def get_album
		@album = Album.find params[:album_id] if !params[:album_id].blank?
	end
  
	def add_common_breadcrumb
		add_breadcrumb(t("cpanel.pages.albums.index"), cpanel_albums_path)
    add_breadcrumb(@album.title, cpanel_album_photos_path(@album))
	end
  
end
