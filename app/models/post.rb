class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, class_name: 'Like', dependent: :destroy

  after_save :update_posts

  def display_comments
    comments.order(created_at: desc).limit(5)
  end

  private

  def update_posts
    author.increment(:posts_counter)
  end
end
