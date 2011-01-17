class AboutController < ApplicationController
  def index
    
  end
  
  def homepage
    @photos = Photo.find(:all, :order => "created_at DESC", :limit => 32)
    @events = Event.find(:all, :conditions => ["canceled_at IS NULL"], :order => "commence_at ASC", :limit => 5)
  end
  
  def jobs
  end

  def advertisers
  end

end
