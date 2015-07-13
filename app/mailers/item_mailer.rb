class ItemMailer < ApplicationMailer
  default from: "shopper@cat-clothes.com"

  def purchased item, purchaser
    @item, @purchaser = item, purchaser
    mail(
      to: item.seller.email,
      subject: "New order - #{item.name}"
    )
  end
end
