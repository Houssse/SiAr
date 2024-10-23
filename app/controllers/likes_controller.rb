class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_likeable

  def create
    like = @likeable.likes.find_or_initialize_by(user: current_user)

    if params[:like_type].to_i == 1

      if like.persisted? && like.like_type == 1
        # Если лайк существует, удаляем его
        like.destroy
        return redirect_back(fallback_location: root_path)
      end

      like.like_type = 1  # Устанавливаем лайк

    elsif params[:like_type].to_i == -1

      if like.persisted? && like.like_type == -1
        # Если дизлайк существует, удаляем его
        like.destroy
        return redirect_back(fallback_location: root_path)
      end

      like.like_type = -1  # Устанавливаем дизлайк
    end

    like.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
      format.json { render json: { success: true }, status: :ok }
    end
  end

  private

  def find_likeable
    @likeable = Article.find(params[:article_id]) if params[:article_id]
  end
end
