class Article < ApplicationRecord
  include ContentValidation
  include DisLikesCount

  belongs_to :user

  has_rich_text :content

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, length: { minimum: 5, maximum: 100 }
  validate :content_length

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "title", "likes_count", "dislikes_count"] #атрибуты для сортировки
  end
end
