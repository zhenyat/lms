class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string  :title,       null: false
      t.date    :start_date,  null: false
      t.date    :finish_date, null: false
      t.text    :content,     null: false
      t.string  :cover
      t.integer :status,      null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
  end
end
