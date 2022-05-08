class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, comments: 'name of user'
      t.string :phone_number, comments: 'phone_number of user'
      t.string :avatar, comments: 'avatar link of user'
      t.string :email, comments: 'email of user'
      t.boolean :confirmed, comments: 'Whether the user is confirmed'
      t.string :password_digest, comments: 'password of user'
      t.boolean :admin, default: false, comments: 'Administrator or not'
      
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
  end
end
