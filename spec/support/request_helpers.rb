module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def set_header_properties
      api_header
      api_response_format
    end

    def set_header_token(token)
      request.headers["Authorization"] = token
    end

    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.marketplace.v#{version}"
    end

    def api_response_format
      request.headers['Accept'] = "#{request.headers['Accept']}, #{Mime::JSON}"
      request.headers['Content-Type'] = Mime::JSON.to_s
    end
  end
end