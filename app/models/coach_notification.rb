class CoachNotification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :coach

#   scope :with_user, { where(coach_id: @coach.id, user_id: @invitation.user.id) }
end
