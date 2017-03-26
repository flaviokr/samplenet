require 'neo4j'
require 'neo4j/core/cypher_session/adaptors/http'

Neo4j::ActiveBase.current_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new("http://neo4j:#{ENV['PASSWORD']}@localhost:7474", wrap_level: :proc)
