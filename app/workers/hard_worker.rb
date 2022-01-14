class HardWorker
  include Sidekiq::Worker

  def perform(_name, _count)
    puts 'Doing hard work'
  end
end
