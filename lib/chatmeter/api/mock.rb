require 'chatmeter/api/mock/user_management'
require 'chatmeter/api/mock/single_signon'
require 'chatmeter/api/mock/group'
require 'chatmeter/api/mock/login'

module Chatmeter
  class API
    module Mock

      @mock_data = Hash.new do |hash, key|
        hash[key] = {}
      end

      def self.parse_stub_params(params)
        mock_data = nil

        if params[:headers].has_key?(:Authorization)
          api_key = params[:headers][:Authorization]

          parsed = params.dup
          begin # try to JSON decode
            parsed[:body] &&= MultiJson.load(parsed[:body])
          rescue # else leave as is
          end
          mock_data = @mock_data[api_key]
        end

        [parsed, mock_data]
      end

    end
  end
end