class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :status, inclusion: { in: %w[pending active completed dropped] }
  validates :grade, numericality: { in: 0..100 }, allow_nil: true
end
