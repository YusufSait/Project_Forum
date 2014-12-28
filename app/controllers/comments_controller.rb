class CommentsController < ApplicationController
  before_filter :require_login, only: [:show, :destroy]

  #@user = current_user
  def create
    @comment = Comment.new(comment_params)
    @comment.topic_id = params[:topic_id]
    @comment.user_id = current_user.id
    @comment.save
    redirect_to topic_path(@comment.topic)
  end

  def destroy
    @comment.destroy
  end

  def show
    @comment_username= User.find(@comment.user_id).username
  end

  def comment_params
    params.require(:comment).permit(:body, :topic_id)
  end

end
