class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references   :user
      t.string    :title
      t.string    :photo_file_name
      t.string    :photo_content_type
      t.string    :photo_file_size
			t.string		:source
			t.string		:eid
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
