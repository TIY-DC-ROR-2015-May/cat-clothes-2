class ItemsController < ApplicationController
  def index
    Item.all
  end
end