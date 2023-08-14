class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :set_user, only: [:likes]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render :edit
    end
  end

  def check
  end

  def withdraw
    @user = current_user
    @user.update(is_withdrawal: true)
    reset_session
    redirect_to root_path
  end
  
  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :encrypted_password, :is_withdrawal)
  end
  
  def ensure_correct_user
    @user = current_user
    unless @user == current_user
      redirect_to users_mypage_path(current_user)
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to users_mypage_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end 
  
end
