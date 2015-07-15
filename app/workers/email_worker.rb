class EmailWorker
  include Sidekiq::Worker

  def perform item_id, user_id
    item = Item.find_by_id item_id
    user = User.find_by_id user_id
    return unless item && user

    ItemMailer.purchased(item, user).deliver_now
  end
end