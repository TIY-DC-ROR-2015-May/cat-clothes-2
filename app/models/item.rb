class Item < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  has_many :orders

  validates_presence_of :name, :price, :seller

  paginates_per 10
end
