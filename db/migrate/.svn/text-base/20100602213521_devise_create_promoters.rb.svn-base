class DeviseCreatePromoters < ActiveRecord::Migration
  def self.up
    create_table(:promoters, :force => true) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
			t.facebook
			
      t.timestamps
      
      t.string :name
      t.string :permalink, :unique => true
    end
    add_index :promoters, :facebook_uid, 					:unique => true
    add_index :promoters, :email,                :unique => true
    add_index :promoters, :confirmation_token,   :unique => true
    add_index :promoters, :reset_password_token, :unique => true
    add_index :promoters, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :promoters
  end
end
