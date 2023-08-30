class Bet < ApplicationRecord
  include AASM

  scope :filter_by_serial_number, -> (serial_number) { where serial_number: serial_number }
  scope :filter_by_item_name, -> (item_name) { includes(:item).where(item: {name: item_name}) }
  scope :filter_by_email, -> (email) { includes(:user).where(user: {email: email }) }
  scope :filter_by_state, -> (state) { where state: state }
  scope :filter_by_start_date, -> (start_date) { where("offline_at >= (?)", start_date)}
  scope :filter_by_end_date, -> (end_date) { where("offline_at < (?)", end_date) }

  belongs_to :item
  belongs_to :user

  after_create :assign_serial_number
  after_create :subtract_coin

  aasm column: :state do
    state :betting, initial: true
    state :won, :lost, :cancelled

    event :won do
      transitions from: :betting, to: :won
    end

    event :lost do
      transitions from: :betting, to: :lost
    end

    event :cancel do
      transitions from: :betting, to: :cancelled, after: :refund_coin
    end
  end

  private

  def subtract_coin
    user.update(coins: user.coins - 1)
  end

  def refund_coin
    user.update(coins: user.coins + 1)
  end

  def assign_serial_number
    number_count = format('%04d', item.bets.where(batch_count: item.batch_count).count)
    date_format = Time.current.strftime('%y%m%d')
    serial_number = "#{date_format}-#{item.id}-#{item.batch_count}-#{number_count}"
    update(serial_number: serial_number)
  end
end
