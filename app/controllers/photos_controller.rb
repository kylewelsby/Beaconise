class PhotosController < ApplicationController
  # before_filter :rightside, :only => [:show]
  # before_filter :subnav, :except => [:index]
  # before_filter :html_title
  # session :cookie_only => false, :only => :create
  def index
    if params[:gallery_id] and params[:user_id]
      redirect_to user_gallery_path(params[:user_id], params[:gallery_id])
    elsif params[:user_id]
      @user ||= User.find_by_permalink(params[:user_id])
      @photos = @user.photos
      # subnav
    elsif params[:event_id]
      @photos = Event.find_by_id(params[:event_id]).photos
      # subnav
    elsif params[:venue_id]
			@photos = Venue.find_by_permalink(params[:venue_id])
		else
      # redirect_to user_galleries_path()
      @photos = Photo.find(:all, :order => "created_at DESC", :limit => 32)
    end
  end

  def show
    if params[:event_id] and params[:venue_id]
      @collection = Venue.find_by_permalink(params[:venue_id]).events.find_by_id(params[:event_id])
    elsif params[:gallery_id] and params[:user_id]
      @collection = User.find_by_permalink(params[:user_id]).galleries.find_by_permalink(params[:gallery_id])
		elsif params[:venue_id]
			@collection = Venue.find_by_permalink(params[:venue_id])
    else
      @photo = Photo.find(params[:id])
      @collection = User.find_by_id(@photo.user_id)
    end
    @photos = @collection.photos
    @photo = @photos.find_by_id(params[:id])
    @q = @collection.photos.find(:first, :conditions => ["id < ?", @photo.id], :limit => 1)
    # @q = @collection.photos.find(:first, :conditions => ["id < ?", params[:id]], :limit => 1)
    
    if @q.nil?
    	@q = @collection.photos.first
    end
    # @photo = @photos.find_by_id(params[:id])
    respond_to do |format|
      format.html { render "index" if @photo.nil? }
      format.xml { render :xml => @photo.to_xml unless @photo.nil? }
    end
  end
  
  def get_single
    @photo = Photo.find_by_id(params[:id])
    @gallery = Gallery.find_by_permalink(params[:gallery_id]) unless params[:gallery_id].nil?
    @event = Event.find_by_id(params[:event_id]) unless params[:event_id].nil?
    if !@gallery.nil?
      @photo_count = @gallery.photos.count
    elsif !@event.nil?
      @photo_count = @event.photos.count 
    else
      @photo_count = 0
    end
    respond_to do |format|
      format.html { redirect_to :show, :id => @photo.id}
      format.js { render :layout => false }
    end
  end
  
  def new
    if defined?(params[:gallery_id])
      @gallery = Gallery.find_by_permalink(params[:gallery_id])
    else
      @gallery = Gallery.find_by_user_id(current_user.id, :conditions => {:title => "Wall Photos"})
    end
    @photo = Photo.new(params[:photo])
    @galleries = Gallery.find(:all, :conditions => {:user_id => current_user.id})
    respond_to do |format|
      format.html 
      format.xml { render :xml => @photo }
    end
  end
  
  def create
    if params[:filedata]
      @photo = Photo.new(:swf_uploaded_data => params[:filedata])
    else
      @photo = Photo.new(params[:photo])
    end
    @photo.user_id = current_user.id
    
    @photo.galleries << Gallery.find_by_permalink(params[:gallery_id]) unless params[:gallery_id].nil?
    @photo.events << Event.find_by_id(params[:event_id]) unless params[:event_id].nil?
    

    # @photo.photo_content_type = MIME::Types.type_for(@photo.photo.original_filename).to_s
    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully uploaded.'
        if params[:filedata]
          format.html { render :text => @photo.photo.url }
          format.xml  { render :nothing => true }
        else
          format.html { redirect_to user_gallery_photos_path }
          format.xml  { render :xml => @photo, :status => :created, :location => @photo }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end


  def set_profile_picture
    @photo = Photo.find_by_id(params[:id])
    if !@photo.nil? and defined?(params[:user_id])
      @gallery = Gallery.find_by_user_id(current_user.id, :conditions => ["profile_pictures = ?", true])
      @gallery = Gallery.create(:user_id => current_user.id, :title => "Profile Photos", :profile_pictures => true) if @gallery.nil?
      @gallery.created_at = Time.now
      @photo.galleries << @gallery
      @photo.save
      flash[:success] = "Photo was successfully set as profile picture"
    end
    redirect_to account_path
  end
  
  def remove_from_gallery
    @photo = Photo.find_by_id(params[:id])
    @gallery = Gallery.find_by_permalink(params[:gallery_id])
    @photo.galleries.delete(@gallery)
    redirect_to(user_gallery_path(@gallery.user, @gallery))
  end
  
  def remove_from_event
    @photo = Photo.find_by_id(params[:id])
    @event = Event.find_by_id(params[:event_id])
    @event.photos.delete(@photo)
    redirect_to(venue_event_photos_path(@event.venue, @event))
  end
  
  def edit
    @photo = Photo.find_by_id(params[:id])
    @gallery = @photo.galleries
    @galleries = Gallery.find(:all, :conditions => {:user_id => current_user.id})
    # @edit_url = user_gallery_photo_path(params[:user_id], params[:gallery_id], @photo)
  end
  
  def update
    @photo = Photo.find_by_id(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:success] = "Updated Photo Successfully" 
        format.html { redirect_to user_gallery_photo_path(params[:user_id], params[:gallery_id], @photo) }
        format.xml { head :ok }
      else
        format.html { render :edit }
        format.xml { render :xml => @photo.errors, :status => :unprocessable_entry}
      end
    end
  end
  
  def destroy
    @photo = Photo.find_by_id(params[:id])
    redirect_to photos_path unless owner_or_admin(@photo)
    
    @photo.destroy
    respond_to do |format|
      flash[:success] = "Photo #{@photo.photo_file_name} successfully deleted"
      format.html {
        if params[:gallery_id]
          redirect_to user_galleries_photos_path(@photo.user.permalink, params[:gallery_id])
        elsif params[:event_id] and params[:venue_id]
          redirect_to venue_event_photos_path(@photo.event.find_by_id(params[:event_id]).venue, @photo.event.find_by_id(params[:event_id]))
          redirect_to user_galleries_path(@photo.user.permalink)
        else
          redirect_to user_photos_path(@photo.user)
        end
      }
      format.xml { head :ok }
    end
  end
  
private
  def html_title
    if defined?(params[:user_id]) && !params[:user_id].nil?
      @html_title = User.find_by_permalink(params[:user_id]).username + "'s Photos"
    elsif defined?(params[:venue_id]) && !params[:venue_id].nil?
      @html_title = Venue.find_by_permalink(params[:venue_id]).username + " Photos"
    end
  end
  def rightside
    @page_class = "profile"
  end
  def subnav
    @page_class = "fullProfile"
  end
end
