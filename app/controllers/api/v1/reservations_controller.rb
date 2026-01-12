class Api::V1::ReservationsController < Api::V1::BaseController
  def create
    result = Reservations::Create.call(payload: request.raw_post)

    if result.success?
      render json: Api::V1::ReservationSerializer
        .new(result.reservation)
        .as_json,
        status: :created
    else
      render json: {
        errors: Api::V1::ErrorSerializer.serialize(result.errors)
      }, status: :unprocessable_entity
    end
  end
end
