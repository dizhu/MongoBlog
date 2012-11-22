class Cpanel::PhotosController < Cpanel::ApplicationController
  
  before_filter :find_album
  before_filter :add_common_breadcrumb, :only => [:index, :show]
  before_filter :find_or_build_photo, :only => [:new, :create, :destroy]
  
  def index
    set_page_tags(t("cpanel.pages.photos.index"))
    @photos = @album.photos.order_by(:created_at => :desc).page(params[:page]).per(Setting.cpanel_album_page_size)
  end
  
  def show
    @photo = Photo.find params[:id]
    set_page_tags(@photo.title)
  end
  
  def new
  end
  
  def create
    respond_to do |format|
      if @photo.save
        format.js { render :nothing => true }
      end
    end
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
	def find_album
		@album = Album.find params[:album_id]
    raise ActiveRecord::RecordNotFound unless @album
	end
  
	def add_common_breadcrumb
		add_breadcrumb(t("cpanel.pages.albums.index"), cpanel_albums_path)
    add_breadcrumb(@album.title, cpanel_album_photos_path(@album))
	end
  
  def find_or_build_photo
    @photo = params[:id] ? @album.photos.find(params[:id]) : @album.photos.build(params[:photo])
  end
  
end
