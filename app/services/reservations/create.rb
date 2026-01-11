module Reservations
  class Create
    def self.call(payload:)
      new(payload).call
    end

    def initialize(payload)
      @payload = payload
    end

    def call
      ActiveRecord::Base.transaction do
        normalized = normalize_payload
        guest = find_or_create_guest(normalized[:guest])
        reservation = guest.reservations.create!(normalized[:reservation])

        ServiceResponse.new(success: true, reservation: reservation)
      end
    rescue => e
      ServiceResponse.new(success: false, errors: [e.message])
    end

    private

    def normalize_payload
      data = JSON.parse(@payload)
      type = Payloads::Resolver.detect(@payload)

      map_payload =
        case type
          when :payload_1 then Payloads::Payload1
          when :payload_2 then Payloads::Payload2
        end

      map_payload.new(data).map
    end

    def find_or_create_guest(attrs)
      Guest.find_or_initialize_by(email: attrs[:email]).tap do |guest|
        guest.update!(attrs)
      end
    end
  end
end