class VenuesGalleries < ActiveRecord::Migration
  def self.up
    create_table :venues_galleries, :id => false do |t|
      t.integer :gallery_id, :null => false
      t.integer :venue_id, :null => false
      t.timestamps
    end
    add_index :venues_galleries, [:gallery_id, :venue_id], :unique => false
  end

  def self.down
    drop_table :venues_galleries
  end
end
