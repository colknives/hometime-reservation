require 'rails_helper'

RSpec.describe Api::V1::ReservationSerializer, type: :serializer do
  let(:guest) do
    double(
      "Guest",
      id: 1,
      email: "wayne_woodbridge@bnb.com",
      first_name: "Wayne",
      last_name: "Woodbridge",
      phone: "639123456789"
    )
  end

  let(:reservation) do
    double(
      "Reservation",
      id: 10,
      start_date: "2021-03-12",
      end_date: "2021-03-16",
      nights: 4,
      guests: 4,
      adults: 2,
      children: 2,
      infants: 0,
      status: "accepted",
      currency: "AUD",
      payout_price: "3800.00",
      security_price: "500",
      total_price: "4500.00",
      guest: guest
    )
  end

  subject { described_class.new(reservation) }

  describe "#as_json" do
    it "returns a hash with the correct reservation data" do
      result = subject.as_json

      expect(result).to have_key(:reservation)
      res_hash = result[:reservation]

      expect(res_hash[:id]).to eq(10)
      expect(res_hash[:start_date]).to eq("2021-03-12")
      expect(res_hash[:end_date]).to eq("2021-03-16")
      expect(res_hash[:nights]).to eq(4)
      expect(res_hash[:guests]).to eq(4)
      expect(res_hash[:adults]).to eq(2)
      expect(res_hash[:children]).to eq(2)
      expect(res_hash[:infants]).to eq(0)
      expect(res_hash[:status]).to eq("accepted")
      expect(res_hash[:currency]).to eq("AUD")
      expect(res_hash[:payout_price]).to eq("3800.00")
      expect(res_hash[:security_price]).to eq("500")
      expect(res_hash[:total_price]).to eq("4500.00")

      guest_hash = res_hash[:guest]
      expect(guest_hash[:id]).to eq(1)
      expect(guest_hash[:email]).to eq("wayne_woodbridge@bnb.com")
      expect(guest_hash[:first_name]).to eq("Wayne")
      expect(guest_hash[:last_name]).to eq("Woodbridge")
      expect(guest_hash[:phone]).to eq("639123456789")
    end
  end
end