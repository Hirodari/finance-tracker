class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token:
        Rails.application.credentials.iex_client[:sandbox_api_key],
    secret_token: 'secret_token', endpoint: 'https://sandbox.iexapis.com/v1')
    #logo
    begin
      fred = {name: client.company(ticker_symbol).company_name, ticker: ticker_symbol,
        last_price: client.price(ticker_symbol), logo: client.logo(ticker_symbol)}
    rescue => exception
      return nil
    end
  end
end
