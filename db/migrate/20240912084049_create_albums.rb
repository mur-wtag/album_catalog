class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
