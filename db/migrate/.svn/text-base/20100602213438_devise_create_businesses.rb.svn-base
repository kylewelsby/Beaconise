class DeviseCreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table(:businesses, :force => true) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
			t.facebook

      t.timestamps
    end
		add_index :businesses, :facebook_uid, 					:unique => true
    add_index :businesses, :email,                :unique => true
    add_index :businesses, :confirmation_token,   :unique => true
    add_index :businesses, :reset_password_token, :unique => true
    add_index :businesses, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :businesses
  end
end
