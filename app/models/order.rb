class Order < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates_presence_of :item, :user, :quantity
  # validate quantity > 0?
end
