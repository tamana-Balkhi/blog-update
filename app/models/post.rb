class Post < ApplicationRecord
  after_save :update_posts_counter

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def last_five_comments
    comments.order('created_at Desc').limit(5)
  end

  private

  def update_posts_counter
    author.update(postCounter: author.posts.length)
  end
end
