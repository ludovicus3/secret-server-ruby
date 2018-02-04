module SecretServer
  module Commands
    # Command to initialize a connection to Secret Server
    module Init
      def init!
        raise 'Secret Server URL is not set' unless valid_url?
        args = ['-e', '-u', url]
        args += ['-r', rule] unless rule.nil?
        args += ['-k', key] unless key.nil?
        sdkclient_exec('init', *args)
      end
    end
  end
end
