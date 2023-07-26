require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Post page' do
  before do
    @user = User.create(name: 'user1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Bio 1')
    @post1 = Post.create(author: @user, title: 'Post 1', text: 'Body of post 1')
    @comment1 = Comment.create(post: @post1, author: @user, text: 'Comment 1 on Post 1')
    @comment2 = Comment.create(post: @post1, author: @user, text: 'Comment 2 on Post 1')

    visit user_posts_path(@user)
  end

  scenario "See the user's post" do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.posts.count)
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
  end

  scenario 'See the first comments on a post' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end

  scenario 'See how many comments and likes a post has' do
    expect(page).to have_content(@post1.comments.count)
    expect(page).to have_content(@post1.likes.count)
  end

  scenario "When I click on a post, it redirects me to that post's show page" do
    click_link @post1.title
    expect(current_path).to eq(user_post_path(@user, @post1.id))
  end
end

RSpec.describe 'Post Pagination', type: :feature do
  before do
    @user = User.create(
      name: 'Tom',
      posts_counter: 3,
      photo: 'https://pic.com',
      bio: 'Project manager'
    )

    subject = Post.new(
      author_id: @user.id,
      title: 'Post 2',
      text: 'Text for Post 2',
      comments_counter: 2,
      likes_counter: 2
    )
    subject.save

    10.times do |i|
      @user.posts.create(
        title: "Post #{i + 3}",
        text: "Text for Post #{i + 3}",
        comments_counter: 2,
        likes_counter: 2
      )
    end
  end

  describe 'Post index page' do
    it 'shows a section for pagination if there are more posts than fit on the view' do
      visit user_posts_path(@user.id)

      expect(page).to have_selector('div.pagination')
    end
  end
end
