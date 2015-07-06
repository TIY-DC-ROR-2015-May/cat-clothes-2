class AddSellerToItems < ActiveRecord::Migration
  def change
    add_reference :items, :seller, index: true, foreign_key: true
  end
end
