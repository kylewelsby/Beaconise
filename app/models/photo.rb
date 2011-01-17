# require 'mime/types'
class Photo < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries
  has_and_belongs_to_many :events
  named_scope :profile_photos, :conditions => { :profile_photos => true }
  named_scope :next, lambda { |p| {:conditions => ["id > ?", p.id], :limit => 1, :order => "id"} }
  named_scope :previous, lambda { |p| {:conditions => ["id < ?", p.id], :limit => 1, :order => "id DESC"} }
  default_scope :order => "photos.created_at DESC"
  acts_as_commentable
  
  has_attached_file :photo,
    :styles => { 
      :tiny => ["20x20#",:jpg],
      :thumb => ["30x30#", :jpg],
      :avatar => ["75x75#", :jpg],
      :album => ["130x130>", :jpg],
      :profile => ["130x130#", :jpg],
      :display => "300x300",
      :show => "600x600>"
      },
    :default_url => "/images/errors/missing_:style.jpg",
    :default_style => :avatar
  validates_attachment_presence :photo
  
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/pjpeg", "image/jpg", "image/gif", "image/png"]
  # validates_presence_of     :batch_size
  
  def swf_uploaded_data=(data)
    # data.content_type = MIME::Types.type_for(data.original_filename)
    data.content_type = File.mime_type?(data.original_filename)
    self.photo = data
  end
  # Override Paperclip's setter method so I can access the uploaded file
  def before_save
    # file = photo.queued_for_write[:original].path
    # self.taken_at = date_taken(file)
    # self.device_make = device(file)[0]
    # self.device_model = device(file)[1]
    # self.geo_lat = geo(file)[0]
    # self.geo_lon = geo(file)[1]
    # attachment_for(:photo).assign(file)
  end
  
  def self.per_page
    18
  end
protected
  def date_taken(file)
    match = `identify -verbose #{file.path}`.match(/exif:DateTimeOriginal: ([0-9: ]{19})/)
    return if match.nil?
    DateTime.strptime(match[1], '%Y:%m:%d %H:%M:%S')

  end
  
  def device(file)
    match = Array.new
    match << `identify -verbose #{file.path}`.match(/exif:Make: ([0-9: ]{19})/)
    match << `identify -verbose #{file.path}`.match(/exif:Model: ([0-9: ]{19})/)
    return if match.nil?
    match
  end

  def geo(file)
    match = Array.new
    match << `identify -verbose #{file.path}`.match(/GPSLatitude: ([0-9])/)
    match << `identify -verbose #{file.path}`.match(/GPSLongitude: ([0-9])/)
    return match unless match.nil?
  end
end
