class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :buy]

  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    # PrintWorker.perform_async "Someone asked for the index page"
    # SayWorker.perform_async "You have a visitor"
    
    # If seller belongs_to company and company belongs_to other_table
    # includes(seller: {company: :other_table}) for nested lookups
    @items = Item.page(params[:page]).includes(:seller)
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
    authorize! :read, @item
  end

  def edit
    authorize! :update, @item
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

  def buy
    bought_item = Item.find params[:id]
    ItemMailer.purchased(bought_item, current_user).deliver_now
    redirect_to :back, notice: "Email sent"
  end

private

  def item_params
    params.require(:item).permit(:name, :price, :display_image)
  end

  def set_item
    @item = Item.find params[:id]
  end
end