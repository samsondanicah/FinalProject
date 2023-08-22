class ChangeColumnItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items_category_ships, :items_id, :item_id
  end
end
