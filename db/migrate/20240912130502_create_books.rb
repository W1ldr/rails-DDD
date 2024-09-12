class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.integer :stock
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
