class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.date :date_start
      t.date :date_end
      t.integer :crew_size
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :ship, null: false, foreign_key: true

      t.timestamps
    end
  end
end
