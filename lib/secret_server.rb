# Secret Server SDK client integration for Ruby
module SecretServer
  require_relative 'secret_server/sdk_client'
  require_relative 'secret_server/version'

  class << self
    attr_reader :client

    def module_init!
      @client = SdkClient.new
      self
    end

    def method_missing(m, *params, &block)
      if @client.respond_to?(m)
        @client.send(m, *params, &block)
      else
        super
      end
    end

    def respond_to_missing?(m, p = false)
      @client.respond_to?(m, p) || super
    end
  end
end

SecretServer.module_init!
