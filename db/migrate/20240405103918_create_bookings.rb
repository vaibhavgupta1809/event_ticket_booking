class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :ticket_quantity
      t.references :user, null: false, foreign_key: true, index: true
      t.references :event, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
