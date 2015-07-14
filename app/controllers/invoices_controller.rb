class InvoicesController < ApplicationController
  skip_authorization_check

  def show
    @invoice = Invoice.find(params[:id])
  end
  
end