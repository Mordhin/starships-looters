class AddTotalAmountToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :total_amount, :bigint
  end
end
