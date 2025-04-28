class CreateTeachingAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :teaching_assignments do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :teaching_assignments, [ :teacher_id, :course_id ], unique: true
  end
end
