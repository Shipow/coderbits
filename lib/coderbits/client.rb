require 'faraday'
require 'multi_json'

module Coderbits
  class Client
    # valid options
    OPTIONS = [:account, :callback]

    # connection
    attr_reader :connection

    # Coderbits::Client.new
    #
    # @return @connection
    def initialize
      @connection = Faraday.new url: "https://coderbits.com"
    end

    # Coderbits::Client.new.get username: 'artemeff'
    def get username, options = {}
      response = @connection.get "/#{username}.json", safe(options)

      if options[:callback]
        response.body
      else
        MultiJson.load response.body, symbolize_keys: true
      end
    end

  private

    def safe options
      options.select { |k, v| OPTIONS.include? k }
    end

  end
end