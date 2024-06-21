require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }

  it "is valid with a title of minimum 5 characters" do
    article = build(:article, title: "Title", user: user)
    expect(article).to be_valid  
  end
  
  it "is invalid with a title less than 5 characters" do
    article = build(:article, title: "Test", user: user)
    expect(article).to_not be_valid
    expect(article.errors[:title]).to include("is too short (minimum is 5 characters)")  
  end
  
  it "is valid with a title of maximum 100 characters" do
    article = build(:article, title: "A" * 100, user: user)
    expect(article).to be_valid  
  end
  
  it "is invalid with a title longer than 100 characters" do
    article = build(:article, title: "A" * 101, user: user)
    expect(article).to_not be_valid
    expect(article.errors[:title]).to include("is too long (maximum is 100 characters)")  
  end
  
  it "is valid with a body of minimum 5 characters" do
    article = build(:article, title: "Valid Title", content: "Valid Body", user: user)
    expect(article).to be_valid  
  end

  it "is invalid with a body less than 5 characters" do
    article = build(:article, title: "Valid Title", content: "Test", user: user)
    expect(article).to_not be_valid
    expect(article.errors[:content]).to include("must be at least 5 characters")    
  end
end
