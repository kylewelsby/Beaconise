class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :facebook, :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username, :forename, :surname, :female, :addres1, :address2, :town, :county, :country, :postcode, :mobile, :born_at
  
  has_many :galleries, :order => "galleries.profile_pictures ASC"
  has_many :photos
  has_many :attendees
  
  # validates_presence_of :email, :forename, :surname
  validates_uniqueness_of :username, :allow_blank => true
	validates_uniqueness_of :permalink, :username, :email
	validates_exclusion_of :username, :in => %w( admin superuser new create edit update destroy ), :message => "{{value}} is a restricted username"
  
  # def self.find_for_authentication(conditions = {})
  #   conditions = ["username LIKE ? OR email LIKE ?", conditions[:email], conditions[:email]]
  #   raise StandardError, conditions.inspect
  #   super
  # end
  
  def before_facebook_connect(user,token)
		if token
			MiniFB.post(token, user.id, :type => 'feed', :message => "just joined Beaconise.")
		end
		if user.username
	    self.username         = user.username
		else
			self.username					= user.id
		end
		self.email							= user.email
    self.forename 					= user.first_name
    self.surname  					= user.last_name
    self.born_on  					= user.birthday.try(:to_date)
    self.female     				= user.gender  == "female" ? true : false
		
  end
	
	def after_facebook_connect(fb_session)
		
	end
	
  def before_save
    if username and username != '' and !username.empty?
			self.permalink = username.parameterize
    else
			self.permalink = id.to_s
    end
  end
  
  def to_param
    # "#{id}-#{permalink}"
    permalink
  end
end
