module SecretServer
  module Commands
    # Command to fetch Secret values
    module Secret
      def secret(id, opts = {})
        unless id.is_a?(Integer) && id > 0
          raise ArgumentError, 'id must be a positive integer'
        end
        args = ['-s', id.to_s]
        if opts.key? :field
          args += opts[:field] == :all ? ['-ad'] : ['-f', opts[:field].to_s]
        end
        secret_exec(*args)
      end

      private

      def secret_exec(*args)
        stdout, * = sdkclient_exec('secret', *args)
        stdout.chomp!
        begin
          JSON.parse(stdout)
        rescue JSON::ParserError
          stdout
        end
      end
    end
  end
end
