class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error
  rescue_from JSON::ParserError, with: :render_bad_request
  rescue_from StandardError, with: :render_internal_error

  private

  def render_validation_error(exception)
    render json: {
      status: 422,
      error: "Unprocessable Entity",
      errors: exception.record.errors.to_hash(true)
    }, status: :unprocessable_entity
  end

  def render_bad_request(exception)
    render json: {
      status: 400,
      error: "Bad Request",
      message: exception.message
    }, status: :bad_request
  end

  def render_internal_error(exception)
    Rails.logger.error(exception)
    Rails.logger.error(exception.backtrace.join("\n"))

    response = {
      status: 500,
      error: "Internal Server Error"
    }

    unless Rails.env.production?
      response[:exception] = exception.inspect
    end

    render json: response, status: :internal_server_error
  end
end
