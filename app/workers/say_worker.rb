class SayWorker
  include Sidekiq::Worker

  def perform text
    system "say", text
  end
end