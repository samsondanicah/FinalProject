class Admin::BetsController < AdminController
  before_action :set_bet, only: [:won, :lost, :cancel]

  def index
    @bets = Bet.all

    if params[:serial_number].present?
      @bets = @bets.where(serial_number: params[:serial_number])
    end

    if params[:item_name].present?
      @bets = @bets.joins(:item).where("items.name LIKE ?", "%#{params[:item_name]}%")
    end

    if params[:email].present?
      @bets = @bets.joins(:user).where("users.email LIKE ?", "%#{params[:email]}%")
    end

    if params[:state].present?
      @bets = @bets.where(state: params[:state])
    end

    if params[:start_date].present?
      @bets = @bets.where("created_at >= ?", params[:start_date])
    end

    if params[:end_date].present?
      @bets = @bets.where("created_at <= ?", params[:end_date])
    end
  end

  def win; end

  def lose; end

  def cancel
    @bet = Bet.find(params[:bet_id])
    if @bet.may_cancel?
      flash[:notice] = 'Cancelled successfully'
      @bet.cancel!
    else
      redirect_to bets_path, alert: 'Cancelled Bet'
    end
  end

  private

  def set_bet
    @bet = Bet.find(params[:id])
  end
end

