require 'rails_helper'

RSpec.describe ServiceResponse, type: :service do
  describe "#success?" do
    it "returns true when initialized with success: true" do
      response = described_class.new(success: true)
      expect(response.success?).to be(true)
    end

    it "returns false when initialized with success: false" do
      response = described_class.new(success: false)
      expect(response.success?).to be(false)
    end
  end

  describe "reservation attribute" do
    it "returns the assigned reservation" do
      reservation = double("Reservation")
      response = described_class.new(success: true, reservation: reservation)
      expect(response.reservation).to eq(reservation)
    end

    it "returns nil if no reservation is provided" do
      response = described_class.new(success: true)
      expect(response.reservation).to be_nil
    end
  end

  describe "errors attribute" do
    it "returns the assigned errors array" do
      errors = ["Invalid data"]
      response = described_class.new(success: false, errors: errors)
      expect(response.errors).to eq(errors)
    end

    it "defaults to empty array if errors not provided" do
      response = described_class.new(success: true)
      expect(response.errors).to eq([])
    end
  end
end