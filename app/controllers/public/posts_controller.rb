class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
     redirect_to posts_path(@post)
    else
     @posts = Post.all
     @genres = Genre.all
     render :index
    end
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  
  private

  def post_params
    params.require(:post).permit(:name, :explanation, :address, :spot_image, :genre_id)
  end
end
