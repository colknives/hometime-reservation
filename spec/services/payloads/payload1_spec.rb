require 'rails_helper'

RSpec.describe Payloads::Payload1, type: :service do
  let(:payload_hash) { build(:payload1) }
  let(:payload_json) { payload_hash.to_json }

  describe "#map" do
    subject { described_class.new(payload_json) }

    it "returns a normalized hash with guest and reservation keys" do
      mapped = subject.map

      expect(mapped).to have_key(:guest)
      expect(mapped).to have_key(:reservation)

      guest = mapped[:guest]
      reservation = mapped[:reservation]

      expect(guest[:email]).to eq(payload_hash["guest"]["email"])
      expect(guest[:first_name]).to eq(payload_hash["guest"]["first_name"])
      expect(guest[:last_name]).to eq(payload_hash["guest"]["last_name"])
      expect(guest[:phone]).to eq(payload_hash["guest"]["phone"])

      expect(reservation[:start_date]).to eq(payload_hash["start_date"])
      expect(reservation[:end_date]).to eq(payload_hash["end_date"])
      expect(reservation[:nights]).to eq(payload_hash["nights"])
      expect(reservation[:guests]).to eq(payload_hash["guests"])
      expect(reservation[:adults]).to eq(payload_hash["adults"])
      expect(reservation[:children]).to eq(payload_hash["children"])
      expect(reservation[:infants]).to eq(payload_hash["infants"])
      expect(reservation[:status]).to eq(payload_hash["status"])
      expect(reservation[:currency]).to eq(payload_hash["currency"])
      expect(reservation[:payout_price]).to eq(payload_hash["payout_price"])
      expect(reservation[:security_price]).to eq(payload_hash["security_price"])
      expect(reservation[:total_price]).to eq(payload_hash["total_price"])
    end
  end

  context "when initialized with a Ruby hash instead of JSON" do
    subject { described_class.new(payload_hash) }

    it "still maps correctly" do
      mapped = subject.map
      expect(mapped[:guest][:email]).to eq(payload_hash["guest"]["email"])
    end
  end
end