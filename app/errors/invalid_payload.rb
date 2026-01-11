class InvalidPayload < StandardError
  def message
    "Invalid payload format"
  end
end