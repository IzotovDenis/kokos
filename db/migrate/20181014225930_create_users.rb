class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :name
      t.index ["email"], name: "index_users_on_email", unique: true
      t.timestamps
    end
  end
end
