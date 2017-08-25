class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string  :title,   null: false
      t.text    :content
      t.json    :images
      t.integer :position
      t.integer :status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
