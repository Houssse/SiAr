require 'rails_helper'

RSpec.describe "ArticlesController", type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  after(:all) do
    Warden.test_reset!
  end

  describe "POST /articles" do
    it "creates a new article" do
      article_params = { article: { title: "Test Article", content: "Test Body" } }

      expect {
        post "/articles", params: article_params
      }.to change(Article, :count).by(1)

      expect(response).to redirect_to(article_path(Article.last))
    end
  end

  describe "PATCH /articles/:id" do
    let!(:article) { create(:article, title: "Initial Title", content: "Initial Content", user: @user) }

    it "updates an existing article" do
      updated_title = "Updated Title"
      updated_content = "Updated Content"

      patch "/articles/#{article.id}", params: { article: { title: updated_title, content: updated_content } }

      article.reload

      expect(article.title).to eq(updated_title)
      expect(article.content.body.to_plain_text).to eq(updated_content)
    end
  end

  describe "DELETE /articles/:id" do
    let!(:article) { create(:article, title: "Initial Title", content: "Initial Body", user: @user) }

    it "deletes an existing article" do
      expect {
        delete "/articles/#{article.id}"
      }.to change(Article, :count).by(-1)
    end
  end
end
