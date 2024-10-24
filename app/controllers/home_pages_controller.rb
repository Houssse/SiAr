class HomePagesController < ApplicationController
  def index
    @articles = Article.all.includes(:likes)
  
    # Определяем порядок сортировки
    @sort_order = params[:sort_order] || 'created_at'
    @sort_direction = params[:sort_direction] || 'desc'
  
    if @sort_order == 'likes_count'
      @articles = @articles.sort_by(&:likes_count).reverse # Всегда сортируем по убыванию лайков
    elsif @sort_order == 'created_at'
      @articles = @articles.order(created_at: @sort_direction) # Сортировка по дате создания
    end
  end
  
end