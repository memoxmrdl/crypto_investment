class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins do |t|
      t.string :slug, null: false
      t.string :symbol
      t.string :name
      t.decimal :price, precision: 10, scale: 4, default: "0.0"
      t.decimal :interest_rate, precision: 10, scale: 4, default: "0.0"

      t.timestamps
    end

    add_index :coins, :slug, unique: true
    add_index :coins, :symbol, unique: true
  end
end
