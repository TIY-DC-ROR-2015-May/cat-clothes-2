class SayWorker
  include Sidekiq::Worker

  def perform text
    if rand(1..10) != 1
      # system "say", "That didn't work"
      # 1 / 0
      fail
    else
      system "say", text
    end
  end
end