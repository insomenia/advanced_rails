class Post < ApplicationRecord
  belongs_to :user, counter_cache: :posts_count
  has_many :comments, dependent: :destroy

  has_many :recent_comments, -> { where("created_at > ?", 1.week.ago).order(created_at: :desc) }, class_name: "Comment"
  has_many :approved_comments, -> { where(approved: true) }, class_name: "Comment"

  has_many :commenters, -> { distinct }, through: :comments, source: :user


  has_many :attachments, as: :attachable, dependent: :destroy

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  scope :created_after, ->(date) { where("created_at > ?", date) }
  scope :by_user, ->(user) { where(user_id: user.id) }

  def self.published_by(user)
    published.by_user(user)
  end

  validates :published_at, presence: true, if: :published?
  validates :title, presence: { message: "제목을 입력해주세요" }

  before_validation :generate_slug, if: :new_record?
  before_validation :update_slug, if: -> { title_changed? && !new_record? }

  before_save :set_edited_at, if: :body_changed?

  before_destroy -> { puts "게시글 #{title}이 삭제됩니다." }

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def update_slug
    self.slug = title.parameterize if title.present?
  end

  def set_edited_at
    self.edited_at = Time.current
  end
end
