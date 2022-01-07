class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  belongs_to :technique

  enum status: %i[recommended in_progress compeleted], _prefix: :status
end
