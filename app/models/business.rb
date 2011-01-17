class Business < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :facebook, :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :activatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
	has_many :venues
	has_many :events
end
