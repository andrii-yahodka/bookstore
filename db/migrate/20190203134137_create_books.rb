class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.float :price
      t.text :description
      t.integer :publication_year
      t.float :height
      t.float :width
      t.float :depth

      t.timestamps
    end
  end
end
