module Support
  module ControllerHelper
    def response_json
      return nil if response.body.to_s.empty?

      data = JSON.parse(response.body)

      return nil if data.nil?

      if data.is_a?(Array)
        data.map { |d| ActionController::Parameters.new(d) }
      else
        ActionController::Parameters.new(data)
      end
    end

    def response_hash
      json = response_json.as_json
      if response_json.is_a?(Array)
        json.map(&:deep_symbolize_keys)
      else
        json.deep_symbolize_keys
      end
    end
  end
end
