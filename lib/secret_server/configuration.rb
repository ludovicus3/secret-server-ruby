module SecretServer
  # Helpers for working with the Secret Server configuration
  module Configuration
    attr_accessor :path, :url, :rule, :key

    def configure
      yield self
    end

    def env_configure
      configure do |config|
        config.path = ENV['SDK_CLIENT_PATH'] || nil
        config.url = ENV['SECRET_SERVER_URL'] || nil
        config.rule = ENV['SDK_CLIENT_RULE'] || nil
        config.key = ENV['SDK_CLIENT_KEY'] || nil
      end
    end

    def valid_path?
      File.exist? tss
    end

    def valid_url?
      !url.nil?
    end

    def tss
      return @tss if defined? @tss
      @tss = begin
        bin = File.join(path, 'tss.exe')
        bin = File.join(path, 'tss') unless File.exist? bin
        bin
      end
    end
  end
end
