class Gallery < ActiveRecord::Base
  # Associations 
  belongs_to :user
  # has_and_belongs_to_many :venues
  has_and_belongs_to_many :photos, :order => "galleries_photos.created_at DESC, photos.created_at DESC"
  default_scope :order => "galleries.profile_pictures DESC, galleries.created_at DESC"
  
  # has_and_belongs_to_many :events
  # accepts_nested_attributes_for :photos
  
  # Validations
  validates_presence_of :title
  validates_presence_of :user_id
  # Permalink
  def before_save
    if title == "new" or title == "create" or title == "edit" or title == "update" or title == "delete" or title == "destroy" or title == "show" or title == "index"
      self.permalink = title.parameterize + "_gallery" if permalink.blank?
    else
      self.permalink = title.parameterize if permalink.blank?
    end
  end
  
  def to_param
    # "#{id}-#{permalink}"
    permalink
  end
end
