class ItemsCategoryShip < ApplicationRecord

  has_many :items
  has_many :category

end
