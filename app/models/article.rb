class Article < ApplicationRecord
  include ContentValidation

  belongs_to :user

  has_rich_text :content

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, length: { minimum: 5, maximum: 100 }
  validate :content_length

  def likes_count
    likes.where(like_type: 1).count
  end

  def dislikes_count
    likes.where(like_type: -1).count
  end
end
