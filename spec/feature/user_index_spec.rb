require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio 1')
    @user2 = User.create(name: 'user2', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio 2')
    @post1 = Post.create(author: @user1, title: 'Post 1', text: 'Body of post 1')
    @post2 = Post.create(author: @user2, title: 'Post 2', text: 'Body of post 2')

    visit users_path
  end

  it 'displays the username of all other users' do
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'See the profile picture for each user' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'displays the number of posts each user has written' do
    User.all.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  scenario "When I click, I am redirected to that user's show page" do
    click_link @user1.name
    expect(current_path).to eq(user_path(@user1))
  end
end
