class AddApprovedToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :approved, :boolean
  end
end
