class Article < ApplicationRecord
  include ContentValidation

  has_rich_text :content

  validates :title, length: { minimum: 5, maximum: 100 }
  validate :content_length
end
