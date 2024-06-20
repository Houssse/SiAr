class HomePagesController < ApplicationController
  def index
    @articles = Article.all
  end
end
