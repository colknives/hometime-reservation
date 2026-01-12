require "rails_helper"

RSpec.describe InvalidPayload do
  subject(:error) { described_class.new }

  it "inherits from StandardError" do
    expect(error).to be_a(StandardError)
  end

  it "returns the correct error message" do
    expect(error.message).to eq("Invalid payload format")
  end

  it "can be raised" do
    expect { raise InvalidPayload }.to raise_error(
        InvalidPayload,
        "Invalid payload format"
    )
  end
end
