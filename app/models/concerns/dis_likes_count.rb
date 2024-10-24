module DisLikesCount
  def likes_count
    likes.where(like_type: 1).count
  end

  def dislikes_count
    likes.where(like_type: -1).count
  end
end