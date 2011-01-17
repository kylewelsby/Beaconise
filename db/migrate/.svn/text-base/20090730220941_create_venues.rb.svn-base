class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
			t.references :business
      t.string    :name,            :null => false
      t.string    :permalink,       :null => false
      t.string    :keyword
      t.text      :description
      t.text      :dress_code
      t.string    :address1
      t.string    :address2
      t.string    :city,            :length => 40
      t.string    :county,					:length => 50
      t.string    :country, 				:length => 50
      t.string    :postcode,        :length => 11
      t.string    :lat
      t.string    :lng
      t.string    :website
      t.string    :email
      t.string    :telephone
      t.string    :twitter
      t.string    :logo_file_name
      t.string    :logo_content_type
      t.string    :logo_file_size
			t.string		:tilllate_id
			t.integer		:songkick_id
      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
