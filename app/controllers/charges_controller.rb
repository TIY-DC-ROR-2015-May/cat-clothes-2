class ChargesController < ApplicationController
  skip_authorization_check

  def new 
    @invoice = Invoice.find(params[:invoice_id])
    @amount = @invoice.amount_in_cents
  end

# OR, we could make a service object that does all this logic;

  def create
    @invoice = Invoice.find(params[:invoice_id])
    @amount = @invoice.amount_in_cents
    # TakePaymentJob.perform_later @invoice, params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        amount: @amount,
        currency: "usd",
        source: params["stripeToken"], #SOURCE,
        description: "Cat clothes"
        )
      @invoice.update(paid_at: Time.now, stripe_id: charge["id"])
    rescue Stripe::CardError => e
      flash[:error] = e.message
    end
    flash[:notice] = "Thanks for paying!"
    redirect_to invoice_path(@invoice)
  end


end
