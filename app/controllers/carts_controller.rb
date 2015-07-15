class CartsController < ApplicationController
  skip_authorization_check

  def update
    # my_cart = Cart.new
    # authorize! :update, my_cart
    item = Item.find params[:item_id]

    if session[:cart]
      session[:cart].push item.id
    else
      session[:cart] = [item.id]
    end
    # Want this, but can't store objects in session
    # if session[:cart]
    #   session[:cart].add_item item
    # else
    #   c = Cart.new
    #   c.add_item c
    #   session[:cart] = c
    # end

    # my_cart.add_item item
    redirect_to :back, notice: "#{item.name} has been added to your cart"
  end

  def checkout
    # TODO This is where checkout is having problems.
    # So, if you have just logged in, you don't yet have a session cart. 

    if session[:cart]
      @invoice = Cart.create_invoice(session[:cart])
      redirect_to invoice_path(@invoice)
    else
      redirect_to :back, notice: "You don't have anything in your cart."
    end
  end

end