class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users, :force => true) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
			t.facebook
      # t.lockable

      t.timestamps
      t.string    :username, :unique => true
      t.string    :permalink, :unique => true
      t.boolean   :female
      t.date      :born_on
      t.string    :forename
      t.string    :surname
      t.string    :address1
      t.string    :address2
      t.string    :city
      t.string    :county
      t.string    :country
      t.string    :postcode
      t.string    :mobile, :unique => true
      t.string    :network
      t.string    :twitter
      
    end
		add_index :users, :facebook_uid, 					:unique => true
    add_index :users, :username,                 :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
