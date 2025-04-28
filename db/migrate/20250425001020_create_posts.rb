class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.references :user, null: false, foreign_key: true

      t.datetime :published_at
      t.string :slug

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, [ :user_id, :published_at ]
  end
end
