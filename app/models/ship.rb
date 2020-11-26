class Ship < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :description, :location, :price_per_day, :size, :crew_capacity, presence: true
  validates :price_per_day, :crew_capacity, numericality: { only_integer: true }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :size, :purpose ],
    associated_against: {
      user: [:nickname]
    },
    using: {
      tsearch: { prefix: true }
    }
end
