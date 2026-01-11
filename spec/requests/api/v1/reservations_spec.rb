require 'rails_helper'

RSpec.describe "Api::V1::Reservations", type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } }

  describe "POST /api/v1/reservations" do
    context "when payload is valid (Payload 1 format)" do
      let(:payload) do
        {
          start_date: "2021-03-12",
          end_date: "2021-03-16",
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: "accepted",
          guest: {
            id: 1,
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone: "639123456789",
            email: "wayne_woodbridge@bnb.com"
          },
          currency: "AUD",
          payout_price: "3800.00",
          security_price: "500",
          total_price: "4500.00"
        }.to_json
      end

      it "creates a reservation and returns success" do
        post "/api/v1/reservations", params: payload, headers: headers

        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)

        expect(body["reservation"]["guest"]["email"]).to eq("wayne_woodbridge@bnb.com")
        expect(body["reservation"]["nights"]).to eq(4)
        expect(body["reservation"]["status"]).to eq("accepted")
      end
    end

    context "when payload is valid (Payload 2 format)" do
      let(:payload) do
        {
          reservation: {
            start_date: "2021-03-12",
            end_date: "2021-03-16",
            expected_payout_amount: "3800.00",
            guest_details: {
              localized_description: "4 guests",
              number_of_adults: 2,
              number_of_children: 2,
              number_of_infants: 0
            },
            guest_email: "wayne_woodbridge@bnb.com",
            guest_first_name: "Wayne",
            guest_id: 1,
            guest_last_name: "Woodbridge",
            guest_phone_numbers: ["639123456789"],
            listing_security_price_accurate: "500.00",
            host_currency: "AUD",
            nights: 4,
            number_of_guests: 4,
            status_type: "accepted",
            total_paid_amount_accurate: "4500.00"
          }
        }.to_json
      end

      it "creates a reservation and returns success" do
        post "/api/v1/reservations", params: payload, headers: headers

        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)

        expect(body["reservation"]["guest"]["email"]).to eq("wayne_woodbridge@bnb.com")
        expect(body["reservation"]["nights"]).to eq(4)
        expect(body["reservation"]["status"]).to eq("accepted")
      end
    end

    context "when payload is invalid" do
      let(:payload) { { invalid: "data" }.to_json }

      it "returns an error" do
        post "/api/v1/reservations", params: payload, headers: headers

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body["errors"]).not_to be_empty
      end
    end
  end
end
