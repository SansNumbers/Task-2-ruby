class Response < ApplicationRecord
  #   belongs_to :user, counter_cache: true
  #   belongs_to :problem, counter_cache: true
    belongs_to :invitation, counter_cache: true
end
