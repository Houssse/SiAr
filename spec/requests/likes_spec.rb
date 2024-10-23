require 'rails_helper'

RSpec.describe LikesController, type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  before { sign_in user } # Авторизуем пользователя

  describe 'POST #create' do
    context 'when user is authorized' do
      it 'creates a like' do
        expect {
          post article_likes_path(article, like_type: 1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.to change { article.reload.likes_count }.by(1) # Ожидаем, что количество лайков увеличится на 1

        expect(response).to have_http_status(:success) # Проверяем, что ответ успешный
      end

      it 'removes the like when the user clicks again' do
        post article_likes_path(article, like_type: 1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Поставить лайк

        expect {
          post article_likes_path(article, like_type: 1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Повторно нажимаем лайк
        }.to change { article.reload.likes_count }.by(-1) # Ожидаем, что количество лайков уменьшится на 1

        # Проверяем, что количество лайков теперь 0
        expect(article.reload.likes_count).to eq(0)
      end

      it 'removes the dislike when the user clicks again' do
        post article_likes_path(article, like_type: -1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Поставить дизлайк

        expect {
          post article_likes_path(article, like_type: -1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Повторно нажимаем дизлайк
        }.to change { article.reload.dislikes_count }.by(-1) # Ожидаем, что количество дизлайков уменьшится на 1

        # Проверяем, что количество дизлайков теперь 0
        expect(article.reload.dislikes_count).to eq(0)
      end

      it 'removes the like when the user dislikes' do
        post article_likes_path(article, like_type: 1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Поставить лайк

        expect {
          post article_likes_path(article, like_type: -1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' } # Поставить дизлайк
        }.to change { article.reload.likes_count }.by(-1) # Ожидаем, что количество лайков уменьшится на 1

        # Проверяем, что после дизлайка лайков нет
        expect(article.reload.likes_count).to eq(0)
      end
    end

    context 'when user is not authorized' do
      before { sign_out user } # Выход из системы

      it 'does not create a like' do
        expect {
          post article_likes_path(article, like_type: 1), headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.not_to change { article.reload.likes_count } # Ожидаем, что количество лайков не изменится

        expect(response).to redirect_to(new_user_session_path) # Проверяем, что редирект на страницу входа
      end
    end
  end
end
