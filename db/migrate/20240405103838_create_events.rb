class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :event_date
      t.integer :total_tickets
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :lock_version, default: 0 
      

      t.timestamps
    end
  end
end
