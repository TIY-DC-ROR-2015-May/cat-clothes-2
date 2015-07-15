class EmailWorker < ActiveJob::Base
  queue_as :default

  def perform item, user
    sleep 5
    ItemMailer.purchased(item, user).deliver_now
  end
end