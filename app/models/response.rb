class Response < ApplicationRecord
    belongs_to :coach, counter_cache: true
    belongs_to :recommendation, counter_cache: true
    belongs_to :problem, counter_cache: true
    belongs_to :invitation, counter_cache: true
    belongs_to :technique, counter_cache: true
end
