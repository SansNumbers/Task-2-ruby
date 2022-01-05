class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  has_secure_password

  belongs_to :coach, optional: true

  has_many :notifications

  has_and_belongs_to_many :problems

  has_many :ratings
  has_many :techniques, through: :ratings

  has_many :invitations
  has_many :coaches, through: :invitations

  has_many :recommendations
  has_many :coaches, through: :recommendations

  has_many :recommendations
  has_many :techniques, through: :recommendations

  has_one_attached :avatar

  validates :age, presence: false
  validates :about, presence: false
  validates :gender, presence: false
  enum gender: %i[male female]
end
