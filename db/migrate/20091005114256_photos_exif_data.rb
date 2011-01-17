class PhotosExifData < ActiveRecord::Migration
  def self.up
    add_column :photos, :taken_at, :datetime
    add_column :photos, :device_make, :string
    add_column :photos, :device_model, :string
    add_column :photos, :geo_lat, :decimal
    add_column :photos, :geo_lon, :decimal
  end

  def self.down
    remove_column :photos, :taken_at
    remove_column :photos, :device_make
    remove_column :photos, :device_model
    remove_column :photos, :geo_lat
    remove_column :photos, :geo_lon
  end
end
