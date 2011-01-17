class CreateActs < ActiveRecord::Migration
  def self.up
    create_table :acts do |t|
      t.references  :artist
      t.references  :event
			t.string			:permalink
      t.integer     :position,    :default => 0
      t.integer     :importance,  :default => 0
			t.time				:commence_at
			t.time				:finish_at
      t.timestamps
    end
  end

  def self.down
    drop_table :acts
  end
end
