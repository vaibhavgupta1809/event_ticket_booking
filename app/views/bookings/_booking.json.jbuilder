json.extract! booking, :id, :ticket_quantity, :user_id, :event_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
