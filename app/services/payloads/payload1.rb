module Payloads
  class Payload1 < Base
    def map
      {
        guest: {
          email: data["guest"]["email"],
          first_name: data["guest"]["first_name"],
          last_name: data["guest"]["last_name"],
          phone: data["guest"]["phone"]
        },
        reservation: {
          start_date: data["start_date"],
          end_date: data["end_date"],
          nights: data["nights"],
          guests: data["guests"],
          adults: data["adults"],
          children: data["children"],
          infants: data["infants"],
          status: data["status"],
          currency: data["currency"],
          payout_price: data["payout_price"],
          security_price: data["security_price"],
          total_price: data["total_price"]
        }
      }
    end

    private

    attr_reader :data
  end
end