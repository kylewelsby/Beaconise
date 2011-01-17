class ActsController < ApplicationController
	before_filter :authenticate_business!, :except => [:index]
	before_filter	:get_event
	before_filter :get_act, :except => [:index]
  def index

  end
	
	def new
		@event.artists.build(params[:artist])
	end
	
	def create
		name = params[:name]
		new_artist = Artist.find_or_create_by_name(name)
		begin
			artist_lastfm = get_lastfm('album.getInfo', {:artist => name})
	    new_artist.update_attributes(:name => artist_lastfm['name'], :mbid => artist_lastfm['mbid']) unless artist_lastfm.nil?
		rescue => e
			logger.error("LastFM Error: #{e.message}")
		end
		unless @event.artists.find_by_name(new_artist.name)
			@event.artists << new_artist 
		else
			flash[:error] = "Performace already in the line-up"
		end
	end
	
	def edit
		# edit the set times
	end
	
	def update
		# update the set times
	end
	
	def importance
		respond_to do |format|
			case params[:headline]
			when "true"
				@act.update_attributes(:importance => 1)
				flash[:notice] = "#{@act.artist.name} is now listed headlined."
			else
				@act.update_attributes(:importance => 0)
				flash[:notice] = "#{@act.artist.name} is now listed as a supporting act."
			end
			# flash[:notice] = params[:headline]
			format.html { redirect_to venue_event_acts_path(@event.venue, @event) }
		end
	end
	
	def destroy
		# remove act from listings
		if @act.destroy
			flash[:notice] = "Performace removed from line-up"
		end
		redirect_to venue_event_acts_path(@event.venue, @event)
	end
	
private
	def get_act
		begin
			@act = @event.acts.find(params[:id])
		rescue => e
			flash[:error] = "Error: Could not find associated act - #{e.message}"
			redirect_to venue_event_acts_path(@event.venue, @event)
		end
	end

	def get_event
		begin
			@event = Event.find(params[:event_id])
		rescue Exception => e
			flash[:error] = "Could not find that event : #{e.message}"
			redirect_to events_path
		end
		unless @event
			flash[:error] = "Could not find that event : #{e.message}"
			redirect_to events_path
		end
	end
end
