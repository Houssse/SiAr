require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, email: 'admin@example.com', admin: true) }
  let(:other_user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, user: user, article: article) }

  describe 'DELETE /articles/:article_id/comments/:id' do
    context 'authenticated user' do
      before { sign_in user }

      it 'can delete their own comment' do
        delete article_comment_path(article, comment)
        expect(response).to redirect_to(article_path(article))
        expect(Comment.exists?(comment.id)).to be_falsey
      end
    end

    context 'admin user' do
      before { sign_in admin }

      it 'can delete any comment' do
        delete article_comment_path(article, comment)
        expect(response).to redirect_to(article_path(article))
        expect(Comment.exists?(comment.id)).to be_falsey
      end
    end
  end

  describe 'POST /articles/:article_id/comments' do
    context 'authenticated user' do
      before { sign_in user }

      it 'can create a comment' do
        expect {
          post article_comments_path(article), params: { comment: { body: 'Test comment' } }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to(article_path(article))
      end
    end
  end
end
