class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, class_name: 'Like', dependent: :destroy

  validates :title,presence: true,length: {maximum: 250}
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lik
  after_save :update_posts

  def display_comments
    comments.order(created_at: desc).limit(5)
  end

  private

  def update_posts
    author.increment(:posts_counter)
  end
end
