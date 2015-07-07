class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :orders

  has_many :sold_items, class_name: "Item", foreign_key: :seller_id

  def name
    email.split('@').first.capitalize
  end
end
