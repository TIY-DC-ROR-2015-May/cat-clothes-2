class AddDisplayImageToItems < ActiveRecord::Migration
  def change
    add_column :items, :display_image, :string
  end
end
