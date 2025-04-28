class AddEditedAtToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :edited_at, :datetime
  end
end
