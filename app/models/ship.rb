class Ship < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :description, :location, :price_per_day, :size, :crew_capacity, presence: true
  validates :price_per_day, :crew_capacity, numericality: { only_integer: true }
end
