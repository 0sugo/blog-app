class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @individual_post = User.find(params[:id])
    @posts = Post.where(author_id: params[:id])
  end
end
