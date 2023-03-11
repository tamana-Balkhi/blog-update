class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :postCounter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :email, confirmation: { case_sensitive: false }

  def last_three_posts
    posts.order('created_at Desc').limit(3)
  end

  def all_posts
    posts.order('created_at Desc')
  end
end
