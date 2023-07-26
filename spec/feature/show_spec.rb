require 'rails_helper'

RSpec.feature 'Show page', type: :feature do
  before do
    @user = User.create(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio 1')
    @post1 = Post.create(author: @user, title: 'post 1', text: 'Body of post 1')

    visit user_path(@user)
  end

  scenario "See the user's profile picture" do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  scenario 'See the username of the user' do
    expect(page).to have_content(@user.name)
  end

  scenario 'See the number of posts the user has written' do
    expect(page).to have_content(@user.posts.count)
  end

  scenario 'See the bio of the user' do
    expect(page).to have_content(@user.bio)
  end

  scenario 'A button that lets me view all posts in the post index' do
    expect(page).to have_link('See All', href: user_posts_path(@user))
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    click_link('...', match: :first)
    expect(current_path).to eq("/users/#{@user.id}/posts/#{@post1.id}")
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    click_link 'See All'
    expect(current_path).to eq(user_posts_path(@user))
  end
end
