class Article < ApplicationRecord
  has_rich_text :content

  validates :title, length: { minimum: 5, maximum: 100 }
  validates :content, length: { minimum: 5 }
end
