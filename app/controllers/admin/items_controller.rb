class Admin::ItemsController < AdminController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to items_path
    else
      flash.now[:alert] = 'Item create failed'
      render :new
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to item_path
    else
      flash.now[:alert] = 'Item update failed'
      render :edit
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = 'Item deleted successfully'
    else
      flash[:alert] = 'Item deleted failed'
    end
    redirect_to item_path
  end

  def start
    @item = Item.find(item_params)
    if @item.start
      flash[:notice] = 'Task start successfully.'
    else
      flash[:alert] = 'Start item failed'
    end
    redirect_to admin_items_path
  end

  def pause
    if @item.pause
      flash[:notice] = 'Task paused successfully.'
    else
      flash[:alert] = 'Paused item failed'
    end
    redirect_to admin_items_path
  end

  def end
    if @item.end
      flash[:notice] = 'Task ended successfully.'
    else
      flash[:alert] = 'Ended item failed'
    end
    redirect_to admin_items_path
  end

  def cancel
    if @item.cancel
      flash[:notice] = 'Task cancelled successfully.'
    else
      flash[:alert] = 'Cancelled item failed'
    end
    redirect_to admin_items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets,
                                 :batch_count, :online_at, :offline_at, :status, :start_at, :category_id)
  end
end
