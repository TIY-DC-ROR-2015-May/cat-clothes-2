class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new seller_id: current_user.id
    #@item = current_user.items.new
  end

  def create
    @item = current_user.sold_items.new(item_params)
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
    @item = current_user.sold_items.find params[:id]
  end

  def update
    # NOT Item.find
    @item = current_user.sold_items.find params[:id]
    if @item.update(item_params)
      redirect_to @item, notice: "Item updated"
    else
      flash[:warning] = "Failed to update item"
      render :edit
    end
  end

private

  def item_params
    params.require(:item).permit(:name, :price)
  end
end