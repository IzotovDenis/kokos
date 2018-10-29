class AddImagesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :images, :json
  end
end
