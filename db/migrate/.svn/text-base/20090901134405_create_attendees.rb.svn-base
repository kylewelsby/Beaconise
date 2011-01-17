class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string      :state,       :deafult => "unconfirmed"
      t.string      :method,      :default => "web"
      t.references  :attendable,  :polymorphic => true
      t.references  :user
      t.timestamps
    end
 
    add_index :attendees, :attendable_type
    add_index :attendees, :attendable_id
    add_index :attendees, :user_id
  end
 
  def self.down
    drop_table :attendees
  end
end
