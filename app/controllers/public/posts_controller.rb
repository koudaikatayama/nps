class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_post,only: [:edit]
  
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
      @keyword = params[:keyword]
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
     render 'index'
    end
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @genres = Genre.all
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  
  private

  def post_params
    params.require(:post).permit(:name, :explanation, :address, :spot_image, :genre_id, tag_ids: [])
  end
  
  def correct_post
        @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end
end
