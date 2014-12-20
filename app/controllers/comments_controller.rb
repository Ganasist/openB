class CommentsController < ApplicationController

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to (current_user || current_contractor), notice: 'Comment was deleted' }
      format.js
    end
  end

  private

    # def get_commenterable
    #   @commenterable = current_user || current_contractor
    # end
    #
    # def get_commentable
    #   @commentable = params[:commentable].classify.constantize.find(commentable_id)
    # end
    #
    # def commentable_id
    #   params[(params[:commentable].singularize + '_id').to_sym]
    # end
end
