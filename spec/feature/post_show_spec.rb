require 'rails_helper'

RSpec.feature 'Post show page' do
  before do
    @user = User.create(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio 1')
    @post = Post.create(author: @user, title: 'post 1', text: 'Body of post 1')
    @comment1 = Comment.create(post: @post, author: @user, text: 'Comment 1 on the post')
    @comment2 = Comment.create(post: @post, author: @user, text: 'Comment 2 on the post')

    visit user_post_path(@user, @post.id)
  end

  scenario "See the post's title" do
    expect(page).to have_content(@post.title)
  end

  scenario 'See who wrote the post' do
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the post body' do
    expect(page).to have_content(@post.text)
  end

  scenario 'I can see how many comments it has' do
    expect(page).to have_content(@post.comments.count)
  end

  scenario 'I can see how many likes it has' do
    likes_count = @post.likes.count
    expect(page).to have_content("Likes: #{likes_count}")
  end

  scenario 'I can see the username of each commenter' do
    expect(page).to have_content(@user.name, count: 2)
  end

  scenario 'I can see the comment each commenter left' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
