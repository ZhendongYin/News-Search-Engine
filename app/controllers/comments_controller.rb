class CommentsController < ApplicationController
  def create
    if !current_user
      redirect_to new_session_path
      return
    end
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to  index_path(id: @comment.news_id)
    else
      flash.alert = 'Something went wrong'
      redirect_to index_path(id: @comment.news_id)
    end
  end

  def comment_params
    params.require(:comments).permit(:news_id, :content)
  end
end
