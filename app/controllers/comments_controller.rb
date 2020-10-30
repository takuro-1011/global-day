class CommentsController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   @post = Post.find(params[:post_id])
  #   @comments = @post.comments.includes(:user).order("created_at DESC")
  #   @comment = Comment.new


  def create

    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @comment.user
    end
  end



  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
