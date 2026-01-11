require 'rails_helper'

RSpec.describe Reservations::Create, type: :service do
  let(:guest_email) { "wayne_woodbridge@bnb.com" }

  let(:payload_1) { build(:payload1).to_json }
  let(:payload_2) { build(:payload2).to_json }

  describe ".call" do
    context "with a valid payload_1" do
      it "creates a reservation and guest successfully" do
        response = described_class.call(payload: payload_1)

        expect(response.success?).to be(true)
        expect(response.reservation).to be_a(Reservation)
        expect(response.reservation.guest.email).to eq(guest_email)
      end
    end

    context "with a valid payload_2" do
      it "creates a reservation and guest successfully" do
        response = described_class.call(payload: payload_2)

        expect(response.success?).to be(true)
        expect(response.reservation).to be_a(Reservation)
        expect(response.reservation.guest.email).to eq(guest_email)
      end
    end

    context "when guest already exists" do
      before do
        Guest.create!(
          email: guest_email,
          first_name: "Existing",
          last_name: "Guest",
          phone: "639000000000"
        )
      end

      it "reuses the existing guest record and updates attributes" do
        response = described_class.call(payload: payload_1)

        expect(response.success?).to be(true)
        expect(response.reservation.guest.first_name).to eq("Wayne") # updates the guest
        expect(Guest.where(email: guest_email).count).to eq(1)
      end
    end

    context "with invalid payload" do
      let(:invalid_payload) { { invalid: "data" }.to_json }

      it "returns a failure response" do
        response = described_class.call(payload: invalid_payload)

        expect(response.success?).to be(false)
        expect(response.errors).to_not be_empty
      end
    end
  end
end