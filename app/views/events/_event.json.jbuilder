json.extract! event, :id, :name, :description, :location, :event_date, :total_tickets, :user_id, :lock_version, :created_at, :updated_at
json.url event_url(event, format: :json)
