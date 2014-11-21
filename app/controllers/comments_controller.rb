class CommentsController < ApplicationController
  before_action :get_commentable, only: [:new, :create]
  before_action :get_commenterable, only: [:new, :create]

  def new
    # @comment = Comment.new
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end
 
  def create
    @comment = Comment.create(comment_params)
    @comment.commentable = @commentable
    @comment.commenterable = @commenterable
    if @comment.save
      flash[:notice] = 'Message sent.'
      redirect_to @commentable
    else
      flash[:error] = "#{ @comment.errors.full_messages.to_sentence }"
      render 'new'
    end  
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)      
        format.html { redirect_to @commentable, notice: 'Message updated' }
        format.js
      else
        format.html { render 'edits', notice: "#{ @comment.errors.full_messages.to_sentence }" }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    # @commentable = @comment.commentable
    # @member = (@commentable.is_a?(User) || @commentable.is_a?(Contractor)) ? 
    #            @commentable : 
    #           (@commentable.try(:user) || @commentable.try(:contractor))
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to (current_user || current_contractor), notice: 'Comment was deleted' }
      format.js
    end
  end

  private

    def get_commenterable
      @commenterable = current_user || current_contractor
    end

    def get_commentable
      @commentable = params[:commentable].classify.constantize.find(commentable_id)
    end

    def commentable_id
      params[(params[:commentable].singularize + '_id').to_sym]
    end

    def comment_params
      params.require(:comment).permit(:subject, :body)
    end
end