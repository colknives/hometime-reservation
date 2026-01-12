require "rails_helper"

RSpec.describe Api::V1::ErrorSerializer do
  describe ".serialize" do
    it "serializes ActiveModel errors" do
      errors = { end_date: ["can't be blank"] }

      result = described_class.serialize(errors)

      expect(result).to eq([
        { source: "end_date", message: "can't be blank" }
      ])
    end

    it "serializes array errors" do
      errors = ["Something went wrong"]

      result = described_class.serialize(errors)

      expect(result).to eq([
        { source: "base", message: "Something went wrong" }
      ])
    end
  end
end