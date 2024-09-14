class AddCreatorToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_reference :albums, :created_by
  end
end
