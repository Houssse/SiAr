require 'rails_helper'

RSpec.describe "ArticlesController", type: :request do
  describe "POST /articles" do
    it "creates a new article" do
      article_params = { article: { title: "Test Article", body: "Test Body" } }

      expect {
        post "/articles", params: article_params
      }.to change(Article, :count).by(1)

      expect(response).to redirect_to(article_path(Article.last))
    end
  end

  describe "PATCH /articles/:id" do
    let!(:article) { Article.create(title: "Initial Title", body: "Initial Body") }

    it "updates an existing article" do
      updated_title = "Updated Title"
      updated_body = "Updated Body"

      patch "/articles/#{article.id}", params: { article: { title: updated_title, body: updated_body } }

      article.reload

      expect(article.title).to eq(updated_title)
      expect(article.body).to eq(updated_body)
    end
  end
  
  describe "DELETE /articles/:id" do
    let!(:article) { Article.create(title: "Initial Title", body: "Initial Body") }
    
    it "deletes an existing article" do
      expect {
        delete "/articles/#{article.id}"
      }.to change(Article, :count).by(-1)
    end
  end
end
