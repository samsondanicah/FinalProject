class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.references :items
      t.references :user
      t.integer :batch_count
      t.integer :coins, default: 1
      t.string :state
      t.string :serial_number
      t.timestamps
    end
  end
end
