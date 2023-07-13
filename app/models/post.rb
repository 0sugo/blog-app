class Post < ApplicationRecord
  belongs_to :author, class_name: 'User',foreign_key: 'author_id'
  has_many :comment
  has_many :like
end
