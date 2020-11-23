class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.string :name
      t.text :description
      t.string :origin_universe
      t.string :location
      t.integer :price_per_day
      t.string :purpose
      t.string :size
      t.integer :crew_capacity
      t.boolean :available
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
