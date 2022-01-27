class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  belongs_to :technique

  scope :completed, -> { where(status: 'compeleted') }

  scope :in_progress, -> { where(status: 'in_progress') }

  enum status: %i[recommended in_progress compeleted], _prefix: :status
end
