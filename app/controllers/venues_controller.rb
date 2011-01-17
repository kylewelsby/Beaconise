require 'TillLate'
require 'SongKickr' 

class VenuesController < ApplicationController
  before_filter :authenticate_business!, :except => [:index, :show, :search, :map, :contact]
	before_filter :get_venue, :except => [:index, :search, :new, :create]
  before_filter :rightside, :only => [:show]
  before_filter :subnav, :except => [:index, :show, :new]
  # helper_method :html_title
  # autocomplete_for :venue, :name, :order => "name ASC" do |venues|
  #   venues.map{|venue| " #{venue.id} -- #{venue.name} (#{venue.address_town}, #{venue.address_county})"}.join("\n")
  # end
  
  def index
    # @venues = Venue.paginate(:page => params[:page])
    @venues = Venue.find(:all)
  end

  def show
    @venue = Venue.find_by_permalink(params[:id])

		@events = @venue.events.find(:all, :conditions => ["commence_at >= ?", Time.now], :limit => 7).group_by { |e| e.commence_at.beginning_of_day }
		@events_count = @venue.events.find(:all, :conditions => ["commence_at >= ?", Time.now])
  end

	def search
		@q = params[:query]
		@venues = Venue.name_or_city_like(@q).all
		# @venues = Venue.find(:all, :conditions => ['name LIKE ?', params[:q]], :order => "name ASC", :limit => 8)
		respond_to do |format|
			# format.json { render :json => @venues.to_json }
			format.json { }
			format.xml { render :xml => @venues.to_xml}
			format.js { render :text => @venues.map(&:name) }
			format.html
		end
	end
  
  def details
    @venue = Venue.find_by_permalink(params[:id])
  end
  
  # def times
  #   @venue = Venue.find_by_permalink(params[:id])
  # end
  
  def contact
    @venue = Venue.find_by_permalink(params[:id])
  end
  
  def live_search
    render :autocomplete # Dependancy 
  end
  
  def new
    @venue = Venue.new(params[:venue])
  end
  
  def create
    @venue = Venue.new(params[:venue])
    @venue.business = current_business
    if @venue.save
      flash[:success] = "#{@venue.name} has been successfully added"
      redirect_to venue_path(@venue)
    else
      render :action => :new
    end
  end

	def sync
		@jobs = Delayed::Job.handler_like("struct:VenueEventsJob").handler_like("vid: #{@venue.id}")
		if params[:start]
			if @jobs.size == 0
				Delayed::Job.enqueue VenueEventsJob.new(@venue.id)
				flash[:notice] = "Syncronisation has been started, could take a few minutes."
			else
				flash[:error] = "Syncronisation is already being processed, this action could take a few minuets. Hold tight."
			end
			redirect_to sync_venue_path
		elsif params[:service] and params[:force]
			case params[:service]
			when "tilllate"
				
				@results = TillLate.get_venue_events(@venue.name, @venue.city)
				# flash[:notice] = "Syncing with TillLate: Results found #{@results.first.commence_at}"
				# @results = @venue.get_tilllate_events
				# get and store photos
			when "songkick"
				songkick = Songkickr::Remote.new ENV["songkick_api"]
				
				@results = songkick.events(:venue => @venue.name)
				# @results = @venue.get_songkick_events
			end
			respond_to do |format|
				# format.html { redirect_to sync_venue_path }
				# format.html
				format.json { render :json => @results.to_json }
			end
		end
	end

	def connect
		if params[:service]
			case params[:service]
			when "tilllate"
				# id = @venue.get_tilllate_id
				id = TillLate.get_venue_id(@venue.name, @venue.city)
				if id
					@venue.update_attributes(:tilllate_id => id)
					flash[:success] = t('venues.connect.tilllate.success')
				else
					flash[:error] = t('venues.connect.tilllate.error')
				end
			when "songkick"
				id = @venue.get_songkick_id
				if id
					@venue.update_attributes(:songkick_id => id)
					flash[:success] = t('venues.connect.songkick.success')
				else
					flash[:error] = t('venues.connect.songkick.error')
				end
			end
			redirect_to connect_venue_path
		end
	end
	
	def redirect
		# render :action => 'redirect', :params => {:url => "http://uk.tillate.com"}
	end
 
  def edit
		@venue.genres.new
  end
  
  def update
		begin
			@venue.update_attributes!(	:name => params[:venue][:name], 
															:website => params[:venue][:website],
															:email => params[:venue][:email],
															:telephone => params[:venue][:telephone],
															:twitter => params[:venue][:twitter],
															:description => params[:venue][:description],
															:dress_code => params[:venue][:dress_code],
															:address1 => params[:venue][:address1], 
															:address2 => params[:venue][:address2], 
															:city => params[:venue][:city], 
															:county => params[:venue][:county], 
															:country => params[:venue][:country], 
															:postcode => params[:venue][:postcode],
															:lat => params[:venue][:lat],
															:lng => params[:venue][:lng])
			flash[:success] = "Successfully updated venue"
		rescue => e
			flash[:error] = "Error occured : #{e.message}"
		end
    redirect_to(venue_path)
  end

	def update_permalink
		check = Venue.find_by_permalink(params[:venue][:permalink])
		unless check
			@venue.update_attributes( :permalink => params[:venue][:permalink])
		else
			flash[:error] = "Permalink not available, please choose another."
		end
	end

  def delete
    redirect_to(venue_path) unless admin_signed_in?
  end
  
  def destroy
    if admin_signed_in?
			@venue.destroy 
      flash[:success] = "#{@venue.name} has been removed succesffuly"
      redirect_to venues_path
    else
      flash[:error] = "#{@venue.name} could not be removed"
      venue_path(@venue)
    end
  end
private
	def get_venue
		@venue = Venue.find_by_permalink(params[:id]) 
		@venue = Venue.find(params[:id]) unless @venue
		render :action => "404" unless @venue
	end
  
  def rightside
    @page_class = "profile"
  end
  def subnav
    @page_class = "fullProfile"
  end
end
