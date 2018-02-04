module SecretServer
  module Commands
    # Command to fetch an API token
    module Token
      def token
        stdout, * = sdkclient_exec('token')
        stdout
      end
    end
  end
end
