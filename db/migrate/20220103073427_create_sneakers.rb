class CreateSneakers < ActiveRecord::Migration[6.1]
  def change
    create_table :sneakers do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :gender, null: false, foreign_key: true
      t.string :colors
      t.date :release_date
      t.integer :price
      t.string :shoe_id
      t.string :title
      t.string :image_url

      t.timestamps
    end
    add_index :sneakers, :name
    add_index :sneakers, :shoe_id
  end
end
