require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { build(:comment, user: user, article: article) }

  it 'is created successfully if the user is authenticated' do
    expect(comment).to be_valid
  end

  it 'is not created if the user is not authenticated' do
    comment.user = nil
    expect(comment).not_to be_valid
  end
end
