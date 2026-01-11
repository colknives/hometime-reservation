require 'rails_helper'

RSpec.describe Payloads::Payload2, type: :service do
  let(:payload_hash) { build(:payload2) }
  let(:payload_json) { payload_hash.to_json }

  describe "#map" do
    subject { described_class.new(payload_json) }

    it "returns a normalized hash with guest and reservation keys" do
      mapped = subject.map

      # Top-level keys
      expect(mapped).to have_key(:guest)
      expect(mapped).to have_key(:reservation)

      guest = mapped[:guest]
      reservation = mapped[:reservation]

      # Guest attributes
      expect(guest[:email]).to eq(payload_hash["reservation"]["guest_email"])
      expect(guest[:first_name]).to eq(payload_hash["reservation"]["guest_first_name"])
      expect(guest[:last_name]).to eq(payload_hash["reservation"]["guest_last_name"])
      expect(guest[:phone]).to eq(payload_hash["reservation"]["guest_phone_numbers"].first)

      # Reservation attributes
      expect(reservation[:start_date]).to eq(payload_hash["reservation"]["start_date"])
      expect(reservation[:end_date]).to eq(payload_hash["reservation"]["end_date"])
      expect(reservation[:nights]).to eq(payload_hash["reservation"]["nights"])
      expect(reservation[:guests]).to eq(payload_hash["reservation"]["number_of_guests"])
      expect(reservation[:adults]).to eq(payload_hash["reservation"]["guest_details"]["number_of_adults"])
      expect(reservation[:children]).to eq(payload_hash["reservation"]["guest_details"]["number_of_children"])
      expect(reservation[:infants]).to eq(payload_hash["reservation"]["guest_details"]["number_of_infants"])
      expect(reservation[:status]).to eq(payload_hash["reservation"]["status_type"])
      expect(reservation[:currency]).to eq(payload_hash["reservation"]["host_currency"])
      expect(reservation[:payout_price]).to eq(payload_hash["reservation"]["expected_payout_amount"])
      expect(reservation[:security_price]).to eq(payload_hash["reservation"]["listing_security_price_accurate"])
      expect(reservation[:total_price]).to eq(payload_hash["reservation"]["total_paid_amount_accurate"])
    end
  end

  context "when initialized with a Ruby hash instead of JSON" do
    subject { described_class.new(payload_hash) }

    it "still maps correctly" do
      mapped = subject.map
      expect(mapped[:guest][:email]).to eq(payload_hash["reservation"]["guest_email"])
    end
  end
end