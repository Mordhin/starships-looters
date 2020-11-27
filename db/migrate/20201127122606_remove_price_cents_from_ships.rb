class RemovePriceCentsFromShips < ActiveRecord::Migration[6.0]
  def change
    remove_column :ships, :price_cents, :integer
  end
end
