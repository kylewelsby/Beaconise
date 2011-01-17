class Promoter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :facebook, :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_many :events
  
  def before_save
    if self.name == %W(show new create edit update delete destroy)
      self.permalink = self.id + "-" + self.name.parameterize
    else
      self.permalink = self.name.parameterize
    end
  end
  
  def to_param
    # "#{id}-#{permalink}"
    permalink
  end
end
