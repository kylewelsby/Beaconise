class EventsController < ApplicationController
	before_filter :authenticate_business!, :except => [:index, :show, :flag]
	before_filter :authenticate_user!, :only => [:rsvp]
	before_filter	:get_event, :except => [:index, :new, :create]
  before_filter :rightside, :only => [:show]
  before_filter :subnav, :except => [:index, :show, :new, :edit]
  helper_method :html_title

  def index
    if params[:venue_id]
      @events = Venue.find_by_permalink(params[:venue_id]).events.find(:all, :conditions => ["events.commence_at > ?", Time.now])
    else
			@events = Event.find(:all, :conditions => ["commence_at > ?", Time.now]).reverse
    end
		@events_days = @events.group_by { |e| e.commence_at.beginning_of_day }
  end

  def show
    @event = Event.find_by_id(params[:id])
  end

  def flag
  	
  end
	
	def rsvp
		respond_to do |format|
			if defined?(params[:state])
				@user_rsvp = @event.attending.find_by_user_id(current_user.id)
				
				case params[:state]
				when "attending"
					state = "yes"
				when "was"
					state = "yes"
				when "maybe"
					state = "maybe"
				when "not"
					state = "no"
				end
				if defined?(state)
	        if !@user_rsvp.nil?
	          @user_rsvp.update_attributes(:state => state) unless @user_rsvp.state == state
	        else
	          @event.attending.create(:user_id => current_user.id, :state => state)
	        end
					if @event.commence_at > Time.now
						case state
						when "yes"
							flash[:notice] = t('notice.events.rsvp.yes')
						when "maybe"
							flash[:notice] = t('notice.events.rsvp.maybe')
						when "no"
							flash[:notice] = t('notice.events.rsvp.no')
						end
					else
						case state
						when "yes"
							flash[:notice] = t('notice.events.rsvp.was')
						when "maybe"
							flash[:notice] = t('notice.events.rsvp.unsure')
						when "no"
							flash[:notice] = t('notice.events.rsvp.wasnt')
						end
					end
				else
					flash[:error] = t('error.events.rsvp')
				end
			end
			format.html { redirect_to venue_event_path(@event.venue, @event)}
		end
	end

  def attending
		# Depreciated
		render :rsvp
    @event = Event.find(params[:id])
    respond_to do |format|
      if defined?(params[:attendee][:state])
        @user_rsvp = @event.attending.find_by_user_id(current_user.id)
        if !@user_rsvp.nil?
          @user_rsvp.update_attributes(:state => params[:attendee][:state]) unless @user_rsvp.state == params[:attendee][:state]
        else
          @event.attending.create(:user_id => current_user.id, :state => params[:attendee][:state])
        end
        case params[:attendee][:state]
        when "attending"
          flash[:success] = "Your attending this event, enjoy yourself."
        when "maybe"
          flash[:notice] = "You maybe attending this event, it's not too late."
        when "not_attending"
          flash[:notice] = "Your not attending this event, your going to miss out."
        end
        format.html
        format.js
      else
        format.html
      end
    end
  end
  
  def new
    @venue = Venue.find_by_permalink(params[:venue_id])
    @event = Event.new(params[:event])
		@event.prices.build
		if params[:venue_id]
	    @event.venue_id = @venue.id if params[:venue_id]
			# @event.available_tickets = @venue.capacity
		else
			@event.venue = @event.build_venue
		end
  end
  
  def create
    # @venue = Venue.find_by_permalink(params[:venue_id])
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "You've successfully added a Event."
      # if @event.price > 0 and @event.venue.payment_option.nil?
      #   flash[:success] << ". Payment details need adding to the venue account."
      #   redirect_to :controller => "venue", :action => "payment", :id => @event.venue
      # end
      redirect_to venue_event_path(@event.venue, @event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find_by_id(params[:id])
    # @event.venue.name
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      if params[:event][:revoke] == true
        @event.update_attributes(:canceled_at => '', :canceled_reason => '')
      end
      flash[:success] = "Event details successully updated"
      redirect_to venue_event_path(@event.venue, @event)
    else
      render :action => :edit
    end
  end

  def sync
  	if params[:service]
			case params[:service]
			when "tilllate"
				if @event.get_tilllate_photos
					flash[:success] = "Wow, we found some amazing photos on TillLate for this event"
				end
			end
			redirect_to sync_venue_event_path(@event.venue)
		end
		
  end

  def delete
    @event = Event.find(params[:id])
    redirect_to venue_event_path(@event.venue, @event) unless owner_or_admin(@event)
  end
  
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy and owner_or_admin(@event)
      flash[:success] = "Event successsfully deleted"
    end
    redirect_to venue_events_path(@event.venue)
  end
  
private
	def get_event
		begin
			@venue = Venue.find_by_permalink(params[:venue_id])
			@event = @venue.events.find(params[:id])
		rescue Exception => e
			flash[:error] = "Could not find that event : #{e.message}"
			redirect_to venue_events_path(params[:venue_id])
		end
	end
	
  def html_title
    if defined?(@venue.name) && !params[:user_id].nil? 
      @html_title = @venue.name + "'s Events"
    end
  end
  def rightside
    @page_class = "profile"
  end
  def subnav
    @page_class = "fullProfile"
  end   
end
