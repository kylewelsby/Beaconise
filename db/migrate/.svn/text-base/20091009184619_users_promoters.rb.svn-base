class UsersPromoters < ActiveRecord::Migration
  def self.up
    create_table :users_promoters do |t|
      t.references :user
      t.references :promoter
    end
  end

  def self.down
    drop_table :users_promoters
  end
end
