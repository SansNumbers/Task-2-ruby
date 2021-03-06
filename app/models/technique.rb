class Technique < ApplicationRecord
  has_and_belongs_to_many :problems

  has_many :ratings
  has_many :users, through: :ratings

  has_many :recommendations
  has_many :users, through: :recommendations

  has_many :recommendations
  has_many :coaches, through: :recommendations

  enum gender: %i[male female both]

  has_one_attached :photo

  enum status: %i[new popular], _prefix: :status

  def users_amount
    Recommendation.where(technique_id: id).count
    end

  def likes_amount
    ratings.sum(:like)
  end

  def dislikes_amount
    ratings.sum(:dislike)
  end
end
