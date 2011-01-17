class CreateEventPrices < ActiveRecord::Migration
  def self.up
    create_table :event_prices do |t|
			t.references :event
			t.integer :amount
      t.integer :price
      t.datetime :commence_at
      t.datetime :finish_at
      t.boolean :student
      t.boolean :member
      t.boolean :female

      t.timestamps
    end
  end

  def self.down
    drop_table :event_prices
  end
end
