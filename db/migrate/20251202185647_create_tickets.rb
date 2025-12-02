class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
