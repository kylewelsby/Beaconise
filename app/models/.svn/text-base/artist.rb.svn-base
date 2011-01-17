class Artist < ActiveRecord::Base
  has_many :acts
  has_many :events, :through => :acts
  accepts_nested_attributes_for :acts
  
  validates_presence_of     :name

  def before_save
		# Sync with MusicBrainz
		self.mbid = MusicbrainzAutomatcher.new().match_artist(name) if mbid.blank?
    self.permalink = name.parameterize if permalink.blank?
  end
  
  def to_param
    # "#{id}-#{permalink}"
    permalink
  end
end
