class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ships
  has_many :bookings
  has_one_attached :profile_pic
  has_many :orders
  validates :email, :encrypted_password, :nickname, presence: true
  validates :email, :nickname, uniqueness: true
end
