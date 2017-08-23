class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string  :name,     null: false
      t.string  :title,    null: false
      t.text    :content
      t.string  :cover
      t.integer :position
      t.integer :status,   null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
    add_index :subjects, :name, unique: true
  end
end
