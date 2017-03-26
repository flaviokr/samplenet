class Artist
  include Neo4j::ActiveNode
  id_property :name
  property :country
  property :birth_date

  has_many :in, :albums, origin: :artists

  def tracks
    albums.tracks
  end
end

class Track
  include Neo4j::ActiveNode
  id_property :title
  property :release_date

  has_many :out, :albums, type: :BELONGS_TO

  def artists
    albums.artists
  end
end

class Album
  include Neo4j::ActiveNode
  id_property :title
  property :release_date

  has_many :out, :artists, type: :BELONGS_TO
  has_many :in, :tracks, origin: :albums
end
