class CommentsController < ApplicationController
  before_action :get_commentable

  def new
    @comment = @commentable.comments.build
  end
 
  def create
    @comment = @commentable.comments.create(comment_params)
    if @comment.save
      render json: { message: "success", fileID: @comment.id }, status: 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @comment.errors.full_messages.join(',')}, status: 400
    end     
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @member = (@commentable.is_a?(User) || @commentable.is_a?(Contractor)) ? @commentable : (@commentable.try(:user) || @commentable.try(:contractor))
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Image was deleted' }
      format.js
      format.json { render json: { message: 'File deleted from server', fileID: @comment.id } }
    end
  end

  private

    def get_commentable
      @commentable = params[:commentable].classify.constantize.find(commentable_id)
    end

    def commentable_id
      params[(params[:commentable].singularize + "_id").to_sym]
    end

    def comment_params
      params.require(:comment).permit(:title, :subject, :body)
    end
end