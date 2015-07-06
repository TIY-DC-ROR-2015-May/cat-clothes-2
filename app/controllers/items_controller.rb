class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    Item.all
  end

  def new
    @item = Item.new seller_id: current_user.id
    #@item = current_user.items.new
  end

  def create
  end
end