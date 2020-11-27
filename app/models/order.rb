class Order < ApplicationRecord
  belongs_to :user
  belongs_to :bookings
  monetize :amount_cents
end
