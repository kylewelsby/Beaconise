class GalleriesController < ApplicationController
  before_filter :rightside, :only => [:show]
  before_filter :subnav
  before_filter :html_title
  
  def index
    @top = User.find_by_permalink(params[:user_id])
    @galleries = @top.galleries(:all, :order => "galleries.profile_photos DESC")
    @photos = @top.photos.paginate(:page => params[:page], :order => "photos.created_at DESC")
  end

  def show
    @top = User.find_by_permalink(params[:user_id])
    @gallery = @top.galleries.find_by_permalink(params[:id])
    render :template => "shared/errors/non_existent_gallery" unless @gallery
    # redirect_to new_user_gallery_photo_path if @gallery && @gallery.photos.nil?
  end

  def new
    redirect_to :action => :index
    @gallery = Gallery.new(params[:gallery])
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.user_id = current_user.id
    if @gallery.save
      flash[:success] = "Gallery has been created, now its time to fill it with beautiful photos."
      if params[:venue_id]
        redirect_to venue_gallery_path(params[:venue_id], @gallery)
      else
        redirect_to new_user_gallery_photo_path(params[:user_id], @gallery)
      end
    else
      render :new
    end
  end

  def edit
    @gallery = Gallery.find_by_permalink(params[:id])
    redirect_to user_gallery_path unless owner_or_admin(@gallery)
  end
  
  def update
    @gallery = Gallery.find_by_permalink(params[:id])
    if owner_or_admin(@gallery)
      @gallery.update_attributes(params[:gallery])
      flash[:success] = "Gallery edited succesfully."
    end
    redirect_to user_gallery_path
  end

  def destroy
    @gallery = Gallery.find_by_permalink(params[:id])
    if owner_or_admin(@gallery) and @gallery.profile_pictures == false
      @gallery.destroy
      flash[:success] = "Gallery deleted succesfully."
    end
    redirect_to user_gallery_path
  end
private
  def html_title
    if defined?(params[:user_id]) && !params[:user_id].nil?
      @html_title = User.find_by_permalink(params[:user_id]).username + "'s Photos"
    end
  end
  def rightside
    @page_class = "profile"
  end
  def subnav
    @page_class = "fullProfile"
  end
end
