require 'httparty'

module Alfabank::Api
  class Base
    attr_reader :payment

    def initialize(payment)
      @payment = payment
    end

    private

    def make_request
      HTTParty.post(url, body: generate_params, format: :json)
    end

    def generate_params
      fail NotImplementedError, "this method should be overridden"
    end

    def url
      if Alfabank::Configuration.mode == :test
        self.class::TEST_URL
      elsif Alfabank::Configuration.mode == :production
        self.class::URL
      end
    end
  end
end
