module Api
  module V1
    class ReservationSerializer
      def initialize(reservation)
        @reservation = reservation
      end

      def as_json(*)
        {
          reservation: {
            id: reservation.id,
            start_date: reservation.start_date,
            end_date: reservation.end_date,
            nights: reservation.nights,
            guests: reservation.guests,
            adults: reservation.adults,
            children: reservation.children,
            infants: reservation.infants,
            status: reservation.status,
            currency: reservation.currency,
            payout_price: reservation.payout_price,
            security_price: reservation.security_price,
            total_price: reservation.total_price,
            guest: {
              id: reservation.guest.id,
              email: reservation.guest.email,
              first_name: reservation.guest.first_name,
              last_name: reservation.guest.last_name,
              phone: reservation.guest.phone
            }
          }
        }
      end

      private

      attr_reader :reservation
    end
  end
end
