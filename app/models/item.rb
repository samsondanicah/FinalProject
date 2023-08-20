class Item < ApplicationRecord
  include AASM

  validates :image, :name, :quantity, :minimum_bets, :batch_count, :online_at, :offline_at, :start_at, presence: :true

  belongs_to :user

  default_scope { where(deleted_at: nil) }

  mount_uploader :image, ImageUploader
  enum status: { active: 0, inactive: 1 }

  # pending -> starting
  # starting -> paused
  # starting -> ended
  # starting -> cancelled
  # paused -> starting
  # paused -> cancelled
  # ended -> starting
  # cancelled -> starting

  aasm column: :state do
    state :pending, initial: true
    state :starting, :paused, :ended, :cancelled

    event :start do
      transitions from: [:pending, :ended, :cancelled], to: :starting
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :ended do
      transitions from: :starting, to: :ended
    end

    event :cancelled do
      transitions from: :starting, to: :cancelled
    end

  end

  def destroy
    update(deleted_at: Time.current)
  end
end
