class RepetativeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { secondly(10) }

  def perform
    system "say", "The time is now #{Time.now}"
  end
end