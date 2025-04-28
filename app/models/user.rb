class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :published_posts, -> { where(published: true) }, class_name: "Post"
  has_many :recent_posts, -> { where("created_at > ?", 30.days.ago).order(created_at: :desc) }, class_name: "Post"
  has_many :active_posts, -> { where(status: "active") }, class_name: "Post"

  # user.posts.published
  # user.published_posts
  has_one :profile, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 2, maximum: 50 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 150 }, allow_nil: true

  has_many :enrollments
  has_many :courses, through: :enrollments

  has_many :teaching_assignments, foreign_key: :teacher_id
  has_many :taught_courses, through: :teaching_assignments, source: :course
end
