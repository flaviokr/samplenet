require 'neo4j'
require 'neo4j/session_manager'

Neo4j::ActiveBase.current_session = Neo4j::SessionManager.open_neo4j_session(:http, "http://neo4j:#{ENV['PASSWORD']}@localhost:7474")
