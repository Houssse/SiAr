class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.parent_id = params[:parent_id] if params[:parent_id]

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article }
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.replace(
        "new_comment_form",
        partial: "comments/form",
        locals: { article: @article, comment: @comment }
      )
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.article }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
