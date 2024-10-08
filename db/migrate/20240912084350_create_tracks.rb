class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.references :album, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :duration
      t.string :artist

      t.timestamps
    end
  end
end
