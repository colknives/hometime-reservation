# Hometime Reservations API

This is a Ruby on Rails API for creating reservations.  
The API can accept **two different payload formats** for reservation creation and saves them in a unified `Reservation` model associated with a `Guest`.

---

## Features

- Single API endpoint to create reservations from multiple payload formats
- Automatically parses and normalizes payloads
- Ensures unique guests by email
- Returns the created reservation with guest details
- Fully testable and production-ready code structure

---

## Technology Stack

- Ruby 3.1+
- Rails 8.x API-only
- SQLite3 (default for development)
- RSpec for testing (optional but recommended)

---

## Installation

1. **Clone the repository**

```
git clone git@github.com:colknives/hometime-reservation.git
cd reservations_api
```

2. **Install dependencies**

```
bundle install
```

3. **Set up the database**

```
rails db:create db:migrate
```

## Running the API

Start the Rails server:

```
rails s
```

## Running Unit Test

```
bundle exec rspec
```

## API Endpoint

### Create Reservation

**POST** /api/v1/reservations

**Headers:**

```
Content-Type: application/json
```

**Request Body:**

Payload 1 Sample:

```
{
  "start_date": "2021-03-12",
  "end_date": "2021-03-16",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "id": 1,
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "3800.00",
  "security_price": "500",
  "total_price": "4500.00"
}
```

Payload 2 Sample:

```
{
  "reservation": {
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_id": 1,
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4500.00"
  }
}
```

**Success Response:**

```
{
  "reservation": {
    "id": 4,
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "nights": 4,
    "guests": 4,
    "adults": 2,
    "children": 2,
    "infants": 0,
    "status": "accepted",
    "currency": "AUD",
    "payout_price": "3800.00",
    "security_price": "500.00",
    "total_price": "4500.00",
    "guest": {
      "id": 1,
      "email": "wayne_woodbridge@bnb.com",
      "first_name": "Wayne",
      "last_name": "Woodbridge",
      "phone": "639123456789"
    }
  }
}
```

**Error Response:**

```
{
  "errors": ["Validation failed: Start date can't be blank"]
}
```
