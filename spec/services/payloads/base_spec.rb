require 'rails_helper'

RSpec.describe Payloads::Base, type: :service do
  let(:hash_data) { { "foo" => "bar" } }
  let(:json_data) { hash_data.to_json }

  describe "#initialize" do
    it "assigns a hash correctly" do
      base = described_class.new(hash_data)
      expect(base.instance_variable_get(:@data)).to eq(hash_data)
    end

    it "parses a JSON string correctly" do
      base = described_class.new(json_data)
      expect(base.instance_variable_get(:@data)).to eq(hash_data)
    end
  end

  describe "#map" do
    it "raises NotImplementedError" do
      base = described_class.new(hash_data)
      expect { base.map }.to raise_error(NotImplementedError)
    end
  end
end