class CreateGenresVenues < ActiveRecord::Migration
  def self.up
    create_table :genres_venues, :force => true, :id => false do |t|
      t.references :venue
      t.references :genre
    end
  end

  def self.down
    drop_table :genres_venues
  end
end
