class AddStripesColumnsToBookings < ActiveRecord::Migration[6.0]
  def change
    add_monetize :bookings, :price, currency: { present: false }
    add_column :bookings, :checkout_session_id, :string
  end
end
