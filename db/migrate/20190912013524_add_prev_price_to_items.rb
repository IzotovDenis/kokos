class AddPrevPriceToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :discount_price, :integer, default: 0
  end
end
