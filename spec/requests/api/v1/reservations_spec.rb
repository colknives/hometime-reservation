require "rails_helper"

RSpec.describe "Api::V1::Reservations", type: :request do
  describe "POST /api/v1/reservations" do
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    let(:payload) { build(:payload1).to_json }

    context "when the service succeeds" do
      let(:reservation) { create(:reservation) }

      let(:service_response) do
        ServiceResponse.new(
          success: true,
          reservation: reservation
        )
      end

      before do
        allow(Reservations::Create)
          .to receive(:call)
          .and_return(service_response)

        post "/api/v1/reservations", params: payload, headers: headers
      end

      it "returns HTTP status 201" do
        expect(response).to have_http_status(:created)
      end

      it "returns the serialized reservation" do
        body = JSON.parse(response.body)

        expected =
          JSON.parse(
            Api::V1::ReservationSerializer
              .new(reservation)
              .as_json
              .to_json
          )

        expect(body).to eq(expected)
      end
    end

    context "when the service fails with validation errors" do
      let(:errors) do
        {
          status: ["can't be blank"],
          end_date: ["can't be blank"]
        }
      end

      let(:service_response) do
        ServiceResponse.new(
          success: false,
          errors: errors
        )
      end

      before do
        allow(Reservations::Create)
          .to receive(:call)
          .and_return(service_response)

        post "/api/v1/reservations", params: payload, headers: headers
      end

      it "returns HTTP status 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns serialized errors" do
        body = JSON.parse(response.body)

        expect(body["errors"]).to contain_exactly(
          hash_including("source" => "status", "message" => "can't be blank"),
          hash_including("source" => "end_date", "message" => "can't be blank")
        )
      end
    end
  end
end
