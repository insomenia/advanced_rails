class TeachingAssignment < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :course
end
