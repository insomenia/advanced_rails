class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy

  validate :prevent_circular_reference

  scope :roots, -> { where(parent_id: nil) }

  # Category.roots -> 최상위 카테고리들

  def all_children
    children + children.map(&:all_children).flatten
  end

  def ancestors
    return [] unless parent
    [ parent ] + parent.ancestors
  end

  def prevent_circular_reference
    if parent_id.present? && ancestors.map(&:id).include?(id)
      errors.add(:parent_id, "순환 참조가 발생합니다")
    end
  end
end
