class ForceCreateArtistNameConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Artist, :name, force: true
  end

  def down
    drop_constraint :Artist, :name
  end
end
