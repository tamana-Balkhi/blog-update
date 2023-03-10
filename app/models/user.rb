class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :postCounter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  def last_three_posts
    posts.order('created_at Desc').limit(3)
  end

  def all_posts
    posts.order('created_at Desc')
  end
end
