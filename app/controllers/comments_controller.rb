class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: "comment created"
    else
      flash[:alert] = "comment invalid"
      render "/posts/show"
    end
  end

  def destroy
    post_obj = Post.find params[:post_id]
    comment = post_obj.comments.find params[:id]
    comment.destroy
    redirect_to post_path(post_obj)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
