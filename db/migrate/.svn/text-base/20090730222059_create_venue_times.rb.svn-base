class CreateVenueTimes < ActiveRecord::Migration
  def self.up
    create_table :venue_times do |t|
      t.string  :venue_id
      t.string  :day,       :null => false
      t.time    :open_at,   :null => false
      t.time    :close_at,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :venue_times
  end
end
