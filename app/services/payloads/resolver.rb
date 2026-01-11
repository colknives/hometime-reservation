module Payloads
  class Resolver
    def self.detect(payload)
      data = JSON.parse(payload)

      return :payload_1 if data.key?("guest")
      return :payload_2 if data.key?("reservation")

      raise InvalidPayload
    end
  end
end