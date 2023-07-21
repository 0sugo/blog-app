class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end
end
