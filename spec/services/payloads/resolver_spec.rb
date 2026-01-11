require 'rails_helper'

RSpec.describe Payloads::Resolver, type: :service do
  describe ".detect" do
    context "when payload has 'guest' key" do
      let(:payload_1) { { guest: { email: "test@example.com" } }.to_json }

      it "returns :payload_1" do
        expect(described_class.detect(payload_1)).to eq(:payload_1)
      end
    end

    context "when payload has 'reservation' key" do
      let(:payload_2) { { reservation: { id: 1 } }.to_json }

      it "returns :payload_2" do
        expect(described_class.detect(payload_2)).to eq(:payload_2)
      end
    end

    context "when payload has neither 'guest' nor 'reservation' key" do
      let(:invalid_payload) { { random: "data" }.to_json }

      it "raises InvalidPayload" do
        expect { described_class.detect(invalid_payload) }.to raise_error(InvalidPayload)
      end
    end
  end
end