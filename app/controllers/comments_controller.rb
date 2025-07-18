class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to prototype_path(@comment.prototype), notice: 'コメントを投稿しました'
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end