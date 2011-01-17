require 'nokogiri'
require 'open-uri'
require 'local_file'
require 'geokit'
include Geokit::Geocoders
class Venue < ActiveRecord::Base
  belongs_to :business
  # has_and_belongs_to_many :users, :readonly => true
  # has_many :users, :polymorphic => true
  # has_many :venue_times
  has_many :galleries
	has_many :photos, :through => :galleries
  has_many :events
	has_and_belongs_to_many :genres
  # default_scope :order => "events.commence_at DESC"
  # find_by_autocomplete :name
  acts_as_commentable
  
  has_attached_file :logo,
    :styles => { 
      :tiny => "20x20#",
      :thumb => "30x30#",
			:square => "50x50#",
      :avatar => "75x50>",
      :display => ["150x150", :jpg],
      :profile => ["300x150", :jpg],
      :show => "600X600>"
      },
    :convert_options => {
      :all => "-strip",
      :display => '-background white -flatten -quality 75',
      :profile => '-background white -flatten -quality 75'
    },
    :default_url => "/images/errors/missing_:style.jpg",
    :default_style => :display
    
  validates_attachment_content_type :logo, :content_type => ["image/jpeg", "image/pjpeg", "image/jpg", "image/gif", "image/png"]
  
  validates_presence_of   :name, :city
  validates_uniqueness_of :permalink
  validates_uniqueness_of :keyword, :allow_blank => true
  
  validates_length_of     :keyword, :within => 3..16, :too_short => "please enter atleast count characters", :too_long => "please choose a shorter keyword", :allow_blank => true
  
	def full_address
		addr = ""
		if address1
			addr = addr + address1 + "<br/>"
		end
		if address2
			addr = addr + address2 + "<br/>"
		end
		addr = addr + (city + (county ? " " + county : "") + "<br/>" + postcode + " " + country)
		return addr
	end
	
	def get_songkick_events(page=1)
		logger.debug("Connecting to : http://api.songkick.com/api/3.0/events.json?apikey=#{ENV['songkick_api']}&venue_id=#{songkick_id}")
		begin
			page = Nokogiri::HTML(open("http://api.songkick.com/api/3.0/events.json?apikey=" + ENV['songkick_api'] + "&venue_id=#{self.songkick_id}"))
			RAILS_DEFAULT_LOGGER.debug("Loading events for #{name} from SongKick")
			r = JSON.parse(page)
			r = r['resultsPage']
			pages = r['totalEntries'] / r['perPage'] + 1
			events = r['results']['event']
			if events
				events.each do |event|
					eid = event['id']
					@commence_at = (event['start']['date'] + " " + event['start']['time'].to_s).to_datetime
					if event['end']
						@finish_at = (event['end']['date'] + " " + event['end']['time']).to_datetime
					else
						@finish_at = @commence_at + 5.hours
					end
					artists = event['performance']
					check = Event.venue_id_equals(self.id).commence_at_greater_than_or_equal_to(@commence_at - 1.hour).commence_at_less_than_or_equal_to(@commence_at + 1.hour)
					if check
						if check.first.songkick_id.nil?
							# Update current record
							check.first.update_attribute(:songkick_id => eid)
							logger.debug("Just updated the event record with : SongKick ID")
						end
					else
						# Create new event
						new_event = Event.new(:venue_id => self.id, :commence_at => @commence_at, :finish_at => @finish_at, :songkick_id => eid)
						if new_event.save!
							begin
								artists.each do |artist|
									new_event.add_artist(artist['displayName'])
								end
							rescue Exception => e
								logger.error("Error: SongKick Event Save Failed : #{e.message}")
							end
							events << new_event
						else
							RAILS_DEFAULT_LOGGER.error("Error: Failed to save")
						end
					end
				end
			end
			if r['page'].to_i < pages
				get_songkick_events(r['page'] + 1)
			end
		rescue => e
			logger.error("Error: SongKick Event Failed : #{e.message}")
			return false
		end
		
	end
	
	def get_songkick_id
		logger.debug("Connecting to : http://www.songkick.com/search?type=venues&query=#{name.parameterize(sep = "+")}+#{city.parameterize(sep = "+")}")
		begin
			page = Nokogiri::HTML(open("http://www.songkick.com/search?type=venues&query=#{name.parameterize(sep = "+")}+#{city.parameterize(sep = "+")}"))
			page.css('.vcard a').first['href'].gsub(/^.*\/venues\//,'').gsub(/[\-].*/,'')
		rescue => e
			logger.error("Error: SongKick ID Failed : #{e.message}")
			return false
		end
	end

  def before_create
    if self.name == %w(show new create edit update delete destroy)
      permalink = (id + "-" + name).parameterize
    else
      self.permalink = name.parameterize + "-" + city.parameterize
    end
  end

	def before_save
		
		addr = self.full_address.gsub(/<\/?[^>]*>/,',')
		logger.debug("Connecting to Google to get GeoCode : #{addr}")
		begin
			res = MultiGeocoder.geocode(addr)
			logger.debug(res)
			if res.success
				logger.debug("Retreived : " + res.full_address)
				self.lat = res.lat
				self.lng = res.lng
			end
		rescue Exception => e
			logger.error("Error : Failed to get GeoCode #{e.message}")
		end
	end
  
  def to_param
    # "#{id}-#{permalink}"
    permalink
  end
end
