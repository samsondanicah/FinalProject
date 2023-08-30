class Item < ApplicationRecord
  include AASM

  validates :image, :name, :quantity, :minimum_bets, :batch_count, :online_at, :offline_at, :start_at, presence: :true

  has_many :bets
  has_many :items_category_ships
  has_many :categories, through: :items_category_ships

  validates :name, presence: true
  validates :quantity, presence: true

  default_scope { where(deleted_at: nil) }

  mount_uploader :image, ImageUploader
  enum status: { active: 0, inactive: 1 }


  aasm column: :state do
    state :pending, initial: true
    state :starting, :paused, :ended, :cancelled

    event :start do
      transitions from: [:pending, :ended, :cancelled], to: :starting
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :end do
      transitions from: :starting, to: :ended
    end

    event :cancel do
      transitions from: [:starting, :paused], to: :cancelled
    end

  end

  def destroy
    update(deleted_at: Time.current)
  end
end
