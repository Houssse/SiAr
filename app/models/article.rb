class Article < ApplicationRecord
  validates :title, length: { minimum: 5, maximum: 100 }
  validates :body, length: { minimum: 10 }
end
