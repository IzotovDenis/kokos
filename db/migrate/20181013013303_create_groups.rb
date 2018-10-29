class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :discription
      t.integer :items_count

      t.timestamps
    end
  end
end
