class CommentsController < ApplicationController
  before_action :set_post, only: [ :create ]

  def create
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
        format.turbo_stream
      else
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
