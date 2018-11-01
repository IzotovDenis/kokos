class AddSubTitleToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :subtitle, :string
  end
end
