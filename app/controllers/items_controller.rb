class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new seller_id: current_user.id
    #@item = current_user.items.new
  end

  def create
    create_params = params.require(:item).permit(:name, :price)
    @item = current_user.sold_items.new(create_params)
    if @item.save
      # redirect_to item_path(item)
      redirect_to @item, notice: "Item created"
    else
      render :new
    end
  end
end