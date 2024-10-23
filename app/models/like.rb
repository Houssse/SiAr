class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  #Лайк может быть только 1(лайк) или -1(дизлайк)
  validates :like_type, inclusion: { in: [-1, 1] }
  #Уникальность лайка от одного пользователя
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
end
