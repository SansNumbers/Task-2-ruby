class Coach < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  has_many :users

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

  has_many :coach_notifications

  has_many :recommendations
  has_many :users, through: :recommendations
  has_many :recommendations
  has_many :techniques, through: :recommendations

#   validates :password,
#             presence: true,
#             format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}\z/ },
#             allow_nil: true

  has_one_attached :coach_avatar
end
