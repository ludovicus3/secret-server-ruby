module SecretServer
  module Commands
    # Command to remove a connection with Secret Server
    module Remove
      def remove!
        sdkclient_exec('remove', '-c')
      end
    end
  end
end
