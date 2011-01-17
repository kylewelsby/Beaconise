require 'nokogiri'
require 'open-uri'
require 'local_file'
# require 'last_fm'
class Event < ActiveRecord::Base
  attr_accessor :revoke
  
  # belongs_to  :user
  belongs_to  :venue
  belongs_to  :promoter
	has_many :prices, :class_name => "EventPrice"
  has_and_belongs_to_many :photos, :order => "events_photos.created_at DESC, photos.created_at DESC"
  has_many :attending, :class_name => "Attendee"
	
  has_many :acts, :dependent => :destroy
  # has_many :artists
  has_many :artists, :through => :acts, :order => ["acts.position ASC"]
	
	has_many :performances, :through => :acts
	# has_many :performances
	# has_and_belongs_to_many :genres
  accepts_nested_attributes_for :acts, :artists, :reject_if => proc { |a| a['name'].blank? }
	accepts_nested_attributes_for :prices, :reject_if => proc { |p| p['price'].blank? }
	accepts_nested_attributes_for :venue, :reject_if => proc { |v| v['name'].blank? }
  default_scope :order => "commence_at ASC"

  has_attached_file :poster,
    :styles => { 
      :tiny => "20x35#",
      :thumb => "30x50#",
      :avatar => "75x75#",
      :display => ["100x150", :jpg],
      :profile => ["300x500", :jpg],
      :show => "600X900>"
      },
    :convert_options => {
      :all => "-strip",
      :display => '-background white -flatten -quality 75',
      :profile => '-background white -flatten -quality 75'
    },
    :default_url => "/images/errors/posters/:style/Missing-Poster.jpg",
    :default_style => :display
  # validates_attachment_presence :poster
  validates_attachment_content_type :poster, :content_type => ["image/jpeg", "image/pjpeg", "image/jpg", "image/gif", "image/png"]
  
  validates_presence_of     :commence_at
  validates_date_time       :commence_at, 
                            :before => :finish_at,
                            :before_message => 'must be before %s',
                            :after_message => 'must be after %s'
  validates_date_time       :finish_at,
                            :after => :commence_at,
                            :after_message => "must be after %s"
  validates_presence_of     :venue_id
  # validates_numericality_of :price
  # validates_presence_of     :avalable_tickets
  validates_numericality_of :avalable_tickets,
                            :only_integer => true,
                            :greater_than => 0
  # validates_date_time       :commence_sale_at,
  #                           :before => :commence_at


	validation_group :location, :fields => [:venue, :commence_at, :finish_at]
	validation_group :performances, :fields => [:performances]
	validation_group :pricing, :fields => [:prices]
	validation_group :options, :fields => [:poster]
	
	def get_tilllate_photos
		page = 0
		10.times do 
			begin
				page = page + 1
				get_tilllate_photos_page(page)
			rescue => e
				logger.error("Failed to get photos : #{e.message}")
			end
		end
	end
	
	def get_tilllate_photos_page(num)
		begin
			logger.error("Connecting to TillLate : http://uk.tilllate.com/en/photoalbum/lightoverview/#{tilllate_id.parameterize}/#{num}")
			page = Nokogiri::HTML(open("http://uk.tilllate.com/en/photoalbum/lightoverview/#{tilllate_id.parameterize}/#{num}"))
			
			photos = page.css('table tr td a')
			photos.each do |photo|
				pic = photo.css('img').first
				logger.debug("Handling : #{pic}")
				begin
					eid = photo['href'].gsub(/^.*\/picture\//,'').split('/').first
					full = pic['src'].gsub('_t.','.').gsub('_thumbnail/','')
					begin
						data = Net::HTTP.get_response(URI.parse(full))
						temp = Tempfile.new(eid + "." + data.content_type.split('/').last)
						File.open(temp.path,'w') do |f|
							f.write data.body
						end
						@photo = Photo.new(:title => photo['alt'], :photo => LocalFile.new(temp.path, :content_type => "image/jpeg"))
						if @photo.save!
							@photo.events << self
						else
							logger.error("Failed to save : #{photo['title']} #{temp.content_type}")
						end
					rescue Exception => e
						logger.error("Failed to store photo : #{e.message}")
					end
				rescue Exception => e
					logger.error("Failed to get photo data : #{e.message}")
				end
			end
		rescue Exception => e
			logger.error("Failed to connect to TillLate : #{e.message}")
		end
	end
	
	def add_artist(name)
		begin
			new_artist = Artist.find_or_create_by_name(name)
			begin
				artist_lastfm = get_lastfm('album.getInfo', {:artist => name})
		    new_artist.update_attributes(:name => artist_lastfm['name'], :mbid => artist_lastfm['mbid']) unless artist_lastfm.nil?
			rescue => e
				logger.error("LastFM Error: #{e.message}")
			end
			self.artists << new_artist unless artists.find_by_name(new_artist.name)
		rescue Exception => e
			logger.error("Artist Error: #{e.message}")
		end
		

	end



	def before_validate
		self.commence_at.to_datetime
	end
  def before_save
		if permalink.blank?
			if title
		    self.permalink = title.parameterize
			else
				artists = self.artists.collect{|u| u.name}.join(', ')
				self.title = artists
				self.permalink = title.parameterize
			end
		end
  end
  
  def to_param
    "#{id}-#{permalink}"
    # permalink
  end
end
