class LikesController < ApplicationController
  before_action :find_likeable

  def create
    like = @likeable.likes.find_or_initiaze_by(user: current_user)
    like.like_type = params[:like_type]

    if lake.save
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_likeable
    @likeable = Article.find(params[:article_id]) if params[:article_id]
  end
end
