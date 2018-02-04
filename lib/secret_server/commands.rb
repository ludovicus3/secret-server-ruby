Dir[File.dirname(__FILE__) + '/commands/*.rb'].each do |file|
  require file
end

module SecretServer
  # Wrappers for each command provided by the SDK client tool.
  module Commands
    include SecretServer::Commands::Cache
    include SecretServer::Commands::Init
    include SecretServer::Commands::Remove
    include SecretServer::Commands::Secret
    include SecretServer::Commands::Token
  end
end
