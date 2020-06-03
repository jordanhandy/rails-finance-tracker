class Stock < ApplicationRecord
    # from IEX lookup gem
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:secret_api_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        # create a new Stock object, with the ticker symbol, company name, and price.
        # check the IEX gem documentation for information on how each of these methods are called
          new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    end
end
