class Coach < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  has_secure_password

  validates :age, presence: false
  validates :about, presence: false
  validates :gender, presence: false
  enum gender: %i[male female]

  validates :experience, presence: false
  validates :education, presence: false
  validates :licenses, presence: false
  validates :socials, presence: false

  has_and_belongs_to_many :problems

  has_many :invitations
  has_many :users, through: :invitations

  has_many :notifications

  has_many :recommendations
  has_many :users, through: :recommendations

  has_one_attached :avatar
end
