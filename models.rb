class Artist
  include Neo4j::ActiveNode
  id_property :name
  property :country
  property :birth_date

  has_many :in, :albums, origin: :artists, unique: true

  def tracks
    albums.tracks
  end
end

class Track
  include Neo4j::ActiveNode
  id_property :title
  property :release_year

  has_many :out, :albums, type: :BELONGS_TO, unique: true
  has_many :out, :samples, type: :SAMPLES, model_class: :Track, unique: true

  def artists
    albums.artists
  end
end

class Album
  include Neo4j::ActiveNode
  id_property :title

  has_many :out, :artists, type: :BELONGS_TO, unique: true
  has_many :in, :tracks, origin: :albums, unique: true
end
