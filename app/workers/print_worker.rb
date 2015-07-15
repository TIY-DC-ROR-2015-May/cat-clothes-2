class PrintWorker
  include Sidekiq::Worker

  def perform text
    print "Printing in "
    5.downto 1 do |i|
      puts "#{i} ... "
      sleep 1
    end
    puts text
  end
end