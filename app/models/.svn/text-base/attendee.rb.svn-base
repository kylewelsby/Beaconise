class Attendee < ActiveRecord::Base
  
  # include ActsAsAttendable::Attendee
  
  # belongs_to :attendable, :polymorphic => true
  
  default_scope :order => 'created_at ASC', :conditions => {:state => :attending}

  belongs_to :user
  has_and_belongs_to_many :events
  
end