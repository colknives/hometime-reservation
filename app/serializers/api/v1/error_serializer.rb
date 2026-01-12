module Api
  module V1
    class ErrorSerializer
      def self.serialize(errors)
        return [] if errors.blank?

        if errors.is_a?(Hash)
          from_active_model(errors)
        elsif errors.is_a?(Array)
          from_array(errors)
        else
          from_message(errors)
        end
      end

      private

      def self.from_active_model(errors)
        errors.flat_map do |field, messages|
          messages.map do |message|
            {
              source: field.to_s,
              message: message
            }
          end
        end
      end

      def self.from_array(errors)
        errors.map do |message|
          {
            source: "base",
            message: message
          }
        end
      end

      def self.from_message(message)
        [
          {
            source: "base",
            message: message.to_s
          }
        ]
      end
    end
  end
end
