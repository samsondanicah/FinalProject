class Category < ApplicationRecord
  validates :name, presence: true

  has_many :items_category_ships
  has_many :items, through: :items_category_ships
end