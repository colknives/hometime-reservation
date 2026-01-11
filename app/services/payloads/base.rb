module Payloads
  class Base
    def initialize(data)
      @data = data.is_a?(String) ? JSON.parse(data) : data
    end

    def map
      raise NotImplementedError
    end

    private

    attr_reader :data
  end
end