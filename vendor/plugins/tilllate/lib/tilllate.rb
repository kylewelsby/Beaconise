require 'nokogiri'
require 'open-uri'
require 'local_file'

module Site

	
	def self.included(base)
		base.extend ClassMethods
	end
	
	module ClassMethods
	
		def foo
			puts "Big explotion"
		end
	
    def fetch_page(path)
			data = Nokogiri::HTML(open("http://uk.tilllate.com/en/#{path}"))
			return data
		end
	
		def get_venue_id(name,city)
			begin
				page = fetch_page("search/locations/?q=#{name.parameterize(sep = "+")}+#{city.parameterize(sep = "+")}")
				return page.css('div.location a.blocklink').first['href'].gsub(/^.*\/location\//,'').gsub(/[\?].*/,'')
			rescue Exception => e
				return false
			end
		end
		
		def get_venue_events(name,city)
			vid = get_venue_id(name,city)
			if vid
				events = []
				u_events = get_upcoming_events(name,city)
				p_events = get_past_events(vid,1)
				if !u_events.nil?
					case u_events.size
					when 1
						events << u_events
					else
						u_events.each do |event|
							events << event
						end
					end
				end
				if !p_events.nil?
					case p_events.size
					when 1
						events << p_events
					else
						p_events.each do |event|
							events << event
						end
					end
				end
				return events
			else
				return false
			end
		end
	
		def get_past_events(vid,page)
			events = []
			begin
				if page = fetch_page("location/#{vid}/pastevents/#{page}")	
					reports = page.search('div.photoreport')
					if reports.size > 0 
						reports.each do |event|
							link = event.search('a.blocklink')
							if link
								eid = link.first['href'].gsub(/^.*\/event\//,'')
								events << get_event(eid)
							end
						end
					end
				end
				return events
			rescue => e
			end
		end

		def get_upcoming_events(name,city)
			# Fetches upcoming events using the place name and city
			events = []
			begin
				page = fetch_page("search/events/?q=#{city.parameterize(sep = "+")}+#{name.parameterize(sep = "+")}")
			
				page.css("div.show_events table").each do |day_event|
					day_event.css("tr td a").each do |event|
						eid = event['href'].gsub(/^.*\/event\//,'')
						events << get_event(eid)
					end
				end
			
				return events
			end
		end
	
		def get_event(eid)
			begin
			# Fetch the event page HTML and disect the page, gathering Event information.
			page = fetch_page("event/#{eid}")
		
			details = page.css('table tbody tr')
		
			details.each do |detail|
				el = detail.css('td')
				case el[0].text
				when "Date"
					@date = el[1].text.split(' ')[1].split('.')
				when "Time"
					@time = el[1].text.gsub(' hours','').split(' - ')
				when "Artists"
					@artists = el[1].text
					@artists = @artists.gsub(/\<\/?[^>]*\>/,'').gsub(/[\t\r\n]/,'').split(', ') unless @artists.nil?
					@performances = []
					if @artists.size > 0
						@artists.each do |artist|
							@performances << artist.strip
						end
					else
						@performances << @artists
					end
				when "Price"
					@price = el[1].text.to_f
				when "Minimum Age"
					@min_age = el[1].text.to_i
				when "Description"
					@description = el[1].text
					@description = @description.gsub(/<\/?[^>]*>/,'') unless @description.nil?
				end
			end
			begin
				@title = page.css('h1.maincolumn').text.split(',')[0]
				@title = @title.gsub(/\n/,'') unless @title.nil?
			end
			if @date and @time
				@commence_at = Time.parse("#{@date[2]}/#{@date[1]}/#{@date[0]} #{@time[0]}")
				if @time[0] > @time[1]
					@finish_at = Time.parse("#{@date[2]}/#{@date[1]}/#{@date[0]} #{@time[1]}").tomorrow
				else
					@finish_at = Time.parse("#{@date[2]}/#{@date[1]}/#{@date[0]} #{@time[1]}")
				end

				event = {}
			
				event[:tilllate_id] = eid
				event[:title] = @title ? @title : ''
				event[:description] = @description ? @description : ''
				event[:performances] = @performances
				event[:commence_at] = @commence_at
				event[:finish_at] = @finish_at
				event[:price] = @price ? @price : ''
				event[:min_age] = @min_age ? @min_age : ''
			
				begin
					flyer = page.css('a.flyoutImage').first['href']
					data = Net::HTTP.get_response(URI.parse(flyer))
					temp = Tempfile.new('flyer.jpg')
					File.open(temp.path,'w') do |f|
						f.write data.body
					end
					event[:poster] = LocalFile.new(temp.path)
				rescue => e
					event[:poster] = nil
				end
			
				return event
			end
		rescue
		end
		end

	end
end

class TillLate
	include Site
end