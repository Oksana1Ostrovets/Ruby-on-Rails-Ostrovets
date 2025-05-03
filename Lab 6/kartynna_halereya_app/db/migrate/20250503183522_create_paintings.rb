class CreatePaintings < ActiveRecord::Migration[8.0]
  def change
    create_table :paintings do |t|
      t.string :title
      t.integer :year
      t.decimal :price
      t.references :author, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
