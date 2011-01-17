class EventWizardController < ApplicationController
	act_wizardly_for :event
	
	on_post(:performances) do
		@event.title = @event.name.titleize
	end
	
	on_completed do
		if @event.venue_id.nil?
			redirect_to :action => :location
		else
			redirect_to venue_event_path(@event.venue, @event)
		end
	end
end
