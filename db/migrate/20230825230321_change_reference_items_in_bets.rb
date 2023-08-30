class ChangeReferenceItemsInBets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bets, :items, index: true
    add_reference :bets, :item, index: true
  end
end
