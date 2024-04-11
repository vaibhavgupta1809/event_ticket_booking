class AddAvailableTicketsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :available_tickets, :integer
  end
end

