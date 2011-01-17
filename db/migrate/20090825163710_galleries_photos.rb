class GalleriesPhotos < ActiveRecord::Migration
  def self.up
    create_table :galleries_photos, :id => false do |t|
      t.integer :gallery_id, :null => false
      t.integer :photo_id, :null => false
      t.timestamps
    end
    add_index :galleries_photos, [:gallery_id, :photo_id], :unique => false
  end

  def self.down
    drop_table :galleries_photos
  end
end
