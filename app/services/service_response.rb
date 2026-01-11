class ServiceResponse
  attr_reader :reservation, :errors

  def initialize(success:, reservation: nil, errors: [])
    @success = success
    @reservation = reservation
    @errors = errors
  end

  def success?
    @success
  end
end
