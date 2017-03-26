class ForceCreateAlbumTitleConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Album, :title, force: true
  end

  def down
    drop_constraint :Album, :title
  end
end
