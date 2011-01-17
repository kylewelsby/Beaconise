require "TillLate"
require "SongKickr"
class VenueEventsJob < Struct.new(:vid)
	def perform
		venue = Venue.find(vid)
		if venue.name and venue.city
			
			# Grab all events from TillLate (ScreenScraped)
			# Venue Name and City must be specified.
			if venue.tilllate_id
				events = TillLate.get_venue_events(venue.name, venue.city)
				events.each do |event|
					check_create_event(venue.id, event)
				end
			end
			
			# Grab upcoming events from songkick API
			# SongKick Venue ID must be aquired before continuing. 
			if venue.songkick_id
				remote = Songkickr::Remote.new ENV['songkick_api']
				events = remote.events(:venue_id => venue.songkick_id)
				events.results.each do |event|
					data[:commence_at] = (event.start).to_datetime
					if event.end
						data[:finish_at] = (event.end).to_datetime
					end
					data[:performances] = []
					event.performance.each do |performance|
						data[:performances] << event.performance.display_name
					end
					check_create_event(venue.id, data)
				end
			end
		else
			return false
		end
	end
	
	def check_create_event(vID, event)
		
		# Search events for a event happening 30 mins before or after Grabbed event 
		check = Event.find_by_venue_id(vID, :conditions => ["commence_at >= ? AND commence_at < ?", event[:commence_at] - 30.minutes, event[:commence_at] + 30.minutes])
		if check.blank?
			e = Event.create(	:title => event[:title], 
												:description => event[:description],
												:commence_at => event[:commence_at],
												:finish_at => event[:finish_at],
												:tilllate_id => event[:tilllate_id],
												:venue_id => vID)
		else
			if check.tilllate_id.nil?
				e = check.update_attributes(:tilllate_id => event[:tilllate_id])
			end
		end
		
		# Iterate thrhough each artist check, create and associate
		if event[:performances]
			event[:performances].each do |performance|
				a = Artist.find_or_create_by_name(performance)
				if !e.acts.find_by_artist_id(a.id)
					e.artists << a
				end
			end
		end
	end
end
