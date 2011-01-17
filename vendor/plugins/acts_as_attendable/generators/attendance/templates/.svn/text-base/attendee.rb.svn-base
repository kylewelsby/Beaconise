class Attendee < ActiveRecord::Base
  
  include ActsAsAttendable::Attendee
  
  belongs_to :attendable, :polymorphic => true
  
  default_scope :order => 'created_at ASC'
  
  belongs_to :user
  
end