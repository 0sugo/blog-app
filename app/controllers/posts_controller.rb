class PostsController < ApplicationController
  def index
    # @posts = Post.all
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(:author, comments: :author).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post.includes(:author).find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
