class AddPriceToShips < ActiveRecord::Migration[6.0]
  def change
    add_monetize :ships, :price, currency: { present: false }
  end
end
