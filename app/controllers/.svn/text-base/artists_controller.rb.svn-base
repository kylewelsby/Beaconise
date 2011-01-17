class ArtistsController < ApplicationController
  def index
    @artists = Artist.find(:all, :order => "name ASC")
  end
  def search
		@q = params[:query]
		@artists = Artist.name_like(@q).all

		# @artists = Rockstar::Artist.new(@q)
		respond_to do |format|
			# format.json { render :json => @venues.to_json }
			format.json { }
			format.xml { render :xml => @artists.to_xml}
			format.js { render :text => @artists.map(&:name) }
			format.html
		end
	end
  def show
    @artist = Artist.find_by_permalink(params[:id]) 
    redirect_to artists_path if @artist.nil?
    @artist_lastfm = lastfm_artists_get_info(@artist.name)
  end

  def create
    @event = Event.find_by_id(params[:event_id]) if params[:event_id]
    @artist = Artist.find_or_create_by_name(params[:artist])
    @artist_lastfm = lastfm_artists_get_info(@artist.name)
    @artist.update_attributes(:name => @artist_lastfm['name'], :mbid => @artist_lastfm['mbid']) unless @artist_lastfm.nil?
    respond_to do |format|
      if @event.artists.find_by_id(@artist.id)
        flash[:error] = "#{@artist.name} is already preforming the event listing."
        format.html { 
          redirect_back_or_default events_path
        }
      else
        @event.artists << @artist
        # @act = @event.acts.find_by_artist_id(@artist.id)
        flash[:success] = "#{@artist.name} has been successfully added to the listing."
        format.html { 
          redirect_to venue_event_path(@event.venue, @event)
        }
      end
      format.js
    end
  end
  
  def edit
    @artist = Artist.find_by_permalink(params[:id])
  end
  
  def update
    @artist = Artist.find_by_permalink(params[:id])
    
  end
  
  def destroy
    @artist = Artist.find_by_permalink(params[:id])
    if current_user_is_admin?
      @artist.destroy
      flash[:success] = "#{@artist.name} has been removed successfully."
    end
    redirct_back_or_return artists_path
  end
end
