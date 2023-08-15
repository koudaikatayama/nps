class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_admin.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    redirect_to request.referer
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
