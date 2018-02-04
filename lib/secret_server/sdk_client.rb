require 'json'
require 'open3'
require_relative 'configuration'
require_relative 'commands'

module SecretServer
  # Ruby SDK client for Secret Server
  class SdkClient
    include SecretServer::Configuration
    include SecretServer::Commands

    private

    def sdkclient_exec(*args)
      raise 'SDK client path is invalid' unless valid_path?
      stdout, stderr, status = Open3.capture3(tss, *args)
      raise stdout unless status.exitstatus.zero?
      [stdout, stderr, status]
    end
  end
end
