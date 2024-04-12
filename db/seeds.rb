# Create Users
user1 = User.create!(email: "newuser1@example.com", password: "password1", first_name: "John", last_name: "Doe", role: "user")
user2 = User.create!(email: "user2@example.com", password: "password2", first_name: "Jane", last_name: "Smith", role: "admin")

# Create Events
event1 = Event.create!(
  name: "Concert",
  description: "A great music concert.",
  location: "New York",
  event_date: DateTime.now + 30.days,
  total_tickets: 100,
  available_tickets: 100,
  user: user1
)

event2 = Event.create!(
  name: "Tech Conference",
  description: "Annual tech conference with speakers from around the world.",
  location: "San Francisco",
  event_date: DateTime.now + 60.days,
  total_tickets: 200,
  available_tickets: 200,
  user: user2
)

# Create Bookings
booking1 = Booking.create!(
  ticket_quantity: 2,
  user: user2,
  event: event1
)

booking2 = Booking.create!(
  ticket_quantity: 2,
  user: user2,
  event: event2
)

booking3 = Booking.create!(
  ticket_quantity: 3,
  user: user1,
  event: event2
)

booking3 = Booking.create!(
  ticket_quantity: 3,
  user: user1,
  event: event1
)