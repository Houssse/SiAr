class User < ApplicationRecord

  has_many :articles

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
