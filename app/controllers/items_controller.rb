class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new seller_id: current_user.id
    authorize! :create, @item
    #@item = current_user.items.new
  end

  def create
    @item = current_user.sold_items.new(item_params)
    authorize! :create, @item
    if @item.save
      # redirect_to item_path(item)
      redirect_to @item, notice: "Item created"
    else
      render :new
    end
  end

  def show
    @item = Item.find params[:id]
  end

  def edit
  end

  def update
    authorize! :update, @item
    if @item.update(item_params)
      redirect_to @item, notice: "Item updated"
    else
      flash[:warning] = "Failed to update item"
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @item
    @item.destroy
    redirect_to items_path, notice: "Item deleted"
  end

private

  def item_params
    params.require(:item).permit(:name, :price)
  end

  def set_item
    @item = Item.find params[:id]
  end
end