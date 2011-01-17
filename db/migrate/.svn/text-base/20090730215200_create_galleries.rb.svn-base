class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.references  :user, :null => false
      t.references  :photo
      t.string      :title, :null => false
      t.string      :permalink
      t.string      :description
      t.string      :location
      t.boolean     :profile_pictures
      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
