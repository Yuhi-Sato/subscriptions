class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid
      t.string :name
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :uid, unique: true
  end
end
