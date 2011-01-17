class CreatePromoters < ActiveRecord::Migration
  def self.up
    create_table :promoters do |t|
      t.string  :name, :null => false
      t.string  :permalink, :null => false
      t.string  :email
      t.text    :description
      t.string  :telephone
      t.timestamps
    end
  end

  def self.down
    drop_table :promoters
  end
end
