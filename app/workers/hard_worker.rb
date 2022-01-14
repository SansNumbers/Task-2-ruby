class HardWorker
  include Sidekiq::Worker

  def perform(*_args)
    User.find_each do |user|
      user.recommendations.each do |recommendation|
        if recommendation.step == recommendation.technique.total_steps && recommendation.ended_at.nil?
          UserNotification.create(body: 'Remember to rate the technique, if you liked it', status: true, user_id: user.id)
        end
      end
    end
  end
end
