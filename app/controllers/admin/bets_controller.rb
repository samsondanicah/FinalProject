class Admin::BetsController < AdminController
  def index
    @bets = Bet.new
  end

end
