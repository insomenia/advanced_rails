class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user

  has_many :teaching_assignments
  has_many :teachers, through: :teaching_assignments, source: :user
end
