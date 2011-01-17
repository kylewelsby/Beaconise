class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer   :venue_id
      t.integer   :promoter_id
      t.string    :title
      t.string    :permalink
      t.text      :description
      t.integer   :avalable_tickets
      t.string    :currency
      t.string    :min_age
      t.datetime  :commence_at
      t.datetime  :finish_at
      t.datetime  :canceled_at
      t.string    :canceled_reason
      t.string    :poster_file_name
      t.string    :poster_content_type
      t.string    :poster_file_size
			t.string		:tilllate_id
			t.string		:songkick_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
