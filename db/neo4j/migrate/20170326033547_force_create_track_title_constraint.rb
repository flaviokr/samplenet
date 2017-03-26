class ForceCreateTrackTitleConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Track, :title, force: true
  end

  def down
    drop_constraint :Track, :title
  end
end
