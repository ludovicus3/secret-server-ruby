module SecretServer
  module Commands
    # Command to control caching of Secret values
    module Cache
      # rubocop:disable Naming/ConstantName
      StrategyNever = 0
      StrategyServerThenCache = 1
      StrategyCacheThenServer = 2
      StrategyCacheThenServerAllowExpired = 3
      # rubocop:enable Naming/ConstantName

      def cache_strategy
        stdout, * = sdkclient_exec('cache', '-c')
        result = /Strategy : (\w+)(?:, Max Age : (\d+) minutes)?/.match(stdout)
        strategy = SecretServer::SdkClient.const_get("Strategy#{result[1]}")
        [strategy, result[2].to_i]
      end

      def cache_strategy=(value)
        strategy, age = value.is_a?(Array) ? value : [value, nil]
        validate_cache_strategy_args(strategy, age)
        args = ['cache', '-s', strategy.to_s]
        args += ['-a', age.to_s] unless age.nil?
        sdkclient_exec(*args)
      end

      def cache_age
        cache_strategy[1]
      end

      def cache_age=(age)
        unless age.is_a?(Integer) && age >= 0
          raise ArgumentError, 'age must be a nonnegative integer'
        end
        sdkclient_exec('cache', '-a', age.to_s)
      end

      def cache_clear!
        sdkclient_exec('cache', '-b')
      end

      private

      def validate_cache_strategy_args(strategy, age)
        unless strategy.is_a? Integer
          raise ArgumentError, 'strategy must be an integer'
        end
        unless (0..3).cover? strategy
          raise ArgumentError, 'strategy must be in the range 0 to 3 inclusive'
        end
        unless age.nil? || age.is_a?(Integer) && age >= 0
          raise ArgumentError, 'age must be a nonnegative integer'
        end
        true
      end
    end
  end
end
