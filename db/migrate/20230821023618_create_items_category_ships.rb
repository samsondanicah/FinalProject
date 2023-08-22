class CreateItemsCategoryShips < ActiveRecord::Migration[7.0]
  def change
    create_table :items_category_ships do |t|
      t.references :items
      t.references :category
      t.timestamps
    end
  end
end
