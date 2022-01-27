class CoachNotification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :coach

  scope :with_user, ->(user_id) { where('id > ?', user_id) }
end
