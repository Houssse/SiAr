module DisLikesCount
  extend ActiveSupport::Concern
  
  def likes_count
    likes.where(like_type: 1).count
  end

  def dislikes_count
    likes.where(like_type: -1).count
  end
end