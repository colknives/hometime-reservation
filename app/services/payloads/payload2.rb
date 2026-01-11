module Payloads
  class Payload2 < Base
    def map
      reservation = data["reservation"]

      {
        guest: {
          email: reservation["guest_email"],
          first_name: reservation["guest_first_name"],
          last_name: reservation["guest_last_name"],
          phone: reservation["guest_phone_numbers"]&.first
        },
        reservation: {
          start_date: reservation["start_date"],
          end_date: reservation["end_date"],
          nights: reservation["nights"],
          guests: reservation["number_of_guests"],
          adults: reservation["guest_details"]["number_of_adults"],
          children: reservation["guest_details"]["number_of_children"],
          infants: reservation["guest_details"]["number_of_infants"],
          status: reservation["status_type"],
          currency: reservation["host_currency"],
          payout_price: reservation["expected_payout_amount"],
          security_price: reservation["listing_security_price_accurate"],
          total_price: reservation["total_paid_amount_accurate"]
        }
      }
    end

    private

    attr_reader :data
  end
end