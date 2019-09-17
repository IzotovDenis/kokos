class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :title, default: ""
      t.text :text, default: ""
      t.boolean :all_items, default: false
      t.jsonb :value, default: {}
      t.jsonb :ids, default: []
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
