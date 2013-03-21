require 'coderbits/client'
require 'coderbits/glue'

module Coderbits
  class << self
    # Alias for Coderbits::Client.new
    #
    # @return [Coderbits::Client]
    def new username, options = {}
      Coderbits::Client.new# username, options
    end

    # Alias for Coderbits::Client.new(...).get
    #
    # @return [Hash]
    def get username
      Coderbits::Client.new.get username
    end

    # Alias for Coderbits::Glue.new(...)
    #
    # @return
    def glue username, options = {}
      Coderbits::Glue.new username, options
    end
  end
end