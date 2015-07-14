class Item < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  has_many :orders

  validates_presence_of :name, :price, :seller

  mount_uploader :display_image, PicturesUploader

  paginates_per 20
end
