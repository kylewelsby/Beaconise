class AlterAtendees < ActiveRecord::Migration
  def self.up
    remove_column :attendees, :attendable_type
    rename_column :attendees, :attendable_id, :event_id
  end

  def self.down
    remove_column :attendees, :event_id
    add_column :attendees, :attendable_type
    rename_column :attendees, :attenable_id
    add_index :attendees, :attendable_type
    add_index :attendees, :attendable_id
  end
end
