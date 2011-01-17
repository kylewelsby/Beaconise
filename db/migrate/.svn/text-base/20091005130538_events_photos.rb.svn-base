class EventsPhotos < ActiveRecord::Migration
  def self.up
    create_table :events_photos, :id => false do |t|
      t.integer :event_id, :null => false
      t.integer :photo_id, :null => false
      t.timestamps
    end
    add_index :events_photos, [:event_id, :photo_id], :unique => false
  end

  def self.down
    drop_table :events_photos
  end
end
