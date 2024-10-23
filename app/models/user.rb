class User < ApplicationRecord

  has_many :articles
  has_many :comments
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    %w[email admin name]
  end

  def admin?
    self.admin
  end
end
