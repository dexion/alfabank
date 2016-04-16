module Alfabank::Api
  class PaymentOrderBinding < Base
    TEST_URL = "https://test.paymentgate.ru/testpayment/rest/paymentOrderBinding.do"
    URL = "https://engine.paymentgate.ru/payment/rest/paymentOrderBinding.do"

    def process(binding_id)
      return {url: payment.alfa_form_url} if payment.alfa_order_id
      @binding_id = binding_id

      process_response(make_request.parsed_response)
    rescue
      Alfabank.logger.error e
      {error: 'Internal server error'}
    end

    private

    def process_response(response)
      response
    end

    def generate_params
      params = {
        userName: Alfabank::Configuration.binding_username,
        password: Alfabank::Configuration.binding_password,
        bindingId: @binding_id,
        mdOrder: payment.alfa_order_id
      }
      params.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
