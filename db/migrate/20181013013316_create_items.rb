class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.string :code
      t.string :article
      t.text :description
      t.integer :brand_id
      t.integer :group_id
      t.integer :price
      t.timestamps
    end
  end
end
