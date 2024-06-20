require 'rails_helper'

RSpec.describe Article, type: :model do
  context "validations" do

    it "is valid with a title of minimum 5 charcters" do
      article = Article.new(title: "Title", body: "Valid body")
      expect(article).to be_valid  
    end
    
    it "is invalid with a title less than 5 characters" do
      article = Article.new(title: "Test", body: "Valid Body")
      expect(article).to_not be_valid
      expect(article.errors[:title]).to include("is too short (minimum is 5 characters)")  
    end
    
    it "is valid with a title of maximum 100 characters" do
      article = Article.new(title: "A" * 100, body: "Valid Body")
      expect(article).to be_valid  
    end
    
    it "is invalid with a title longer than 100 characters" do
      article = Article.new(title: "A" * 101, body: "Valid Body")
      expect(article).to_not be_valid
      expect(article.errors[:title]).to include("is too long (maximum is 100 characters)")  
    end
    
    it "is valid with a body of minimum 5 characters" do
      article = Article.new(title: "Valid Title", body: "Valid Body")
      expect(article).to be_valid  
    end

    it "is invalid with a body less than 5 characters" do
      article = Article.new(title: "Valid Title", body: "Test")
      expect(article).to_not be_valid
      expect(article.errors[:body]).to include("is too short (minimum is 5 characters)")    
    end
    
  end
end
