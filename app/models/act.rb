class Act < ActiveRecord::Base
  belongs_to :event
  belongs_to :artist
	validates_presence_of :event, :artist
end
