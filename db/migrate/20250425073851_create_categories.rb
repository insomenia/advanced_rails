class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :categories }
      t.integer :position
      t.text :description

      t.timestamps
    end
    add_index :categories, [ :parent_id, :position ]
  end
end
