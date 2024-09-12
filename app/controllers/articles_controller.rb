class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create ]
  before_action :authorize_user!, only: %i[ edit update destroy ]

  def show
  end

  def new
    @article = current_user.articles.build
    @comment = @article.comments.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article, notice: "Create article."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Updated article."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def authorize_user!
    unless @article.user == current_user || current_user.admin?
      redirect_to root_path
    end
  end
end
