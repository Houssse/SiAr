require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context "with valid attributes" do
      it "creates a new article" do
        expect {
          post :create, params: { article: FactoryBot.attributes_for(:article) }
        }.to change(Article, :count).by(1)
      end
    end
  end

  describe "PATCH #update" do
    before do
      @user = FactoryBot.create(:user)
      @article = FactoryBot.create(:article, user: @user)
      sign_in @user
    end

    context "with valid attributes" do
      it "updates the article of the owner" do
        patch :update, params: { id: @article.id, article: { title: "Updated Title" } }
        @article.reload
        expect(@article.title).to eq("Updated Title")
      end
    end

    context "when user is not the owner of the article" do
      it "does not update the article" do
        other_user = FactoryBot.create(:user)
        sign_in other_user
        patch :update, params: { id: @article.id, article: { title: "Updated Title" } }
        @article.reload
        expect(@article.title).not_to eq("Updated Title")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context "when user is the owner of the article" do
      it "deletes the article" do
        article_to_delete = FactoryBot.create(:article, user: @user)
        expect {
          delete :destroy, params: { id: article_to_delete.id }
        }.to change(Article, :count).by(-1)
      end
    end

    context "when user is not the owner of the article" do
      it "does not delete the article" do
        other_user = FactoryBot.create(:user)
        article_to_delete = FactoryBot.create(:article, user: other_user)
        expect {
          delete :destroy, params: { id: article_to_delete.id }
        }.not_to change(Article, :count)
      end
    end
  end
end
