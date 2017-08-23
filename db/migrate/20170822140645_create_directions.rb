class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.string  :name,    null: false
      t.string  :title,   null: false
      t.string  :cover
      t.integer :position
      t.integer :status,  null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
    add_index :directions, :name, unique: true
  end
end
