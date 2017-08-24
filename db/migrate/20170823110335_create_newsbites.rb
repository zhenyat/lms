class CreateNewsbites < ActiveRecord::Migration[5.1]
  def change
    create_table :newsbites do |t|
      t.string  :title,       null: false
      t.text    :content,     null: false
      t.string  :cover
      t.date    :published_at,             default: Date.today
      t.integer :status,      null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
  end
end
