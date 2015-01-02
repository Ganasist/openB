class UploadsController < ApplicationController
  before_action :get_uploadable, except: :destroy

  def new
  	@upload = @uploadable.uploads.build
  end

  def create
  	@upload = @uploadable.uploads.build(upload_params)
  	if @upload.save
  	  render json: { message: "success", fileID: @upload.id }, status: 200
  	else
  	  #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
  	  render json: { error: @upload.errors.full_messages.join(',') }, status: 400
  	end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to current_member, notice: 'Image was deleted' }
      format.js
      format.json { render json: { message: 'File deleted from server', fileID: @upload.id } }
    end
  end

  private
    def get_uploadable
      @uploadable = params[:uploadable].classify.constantize.find(uploadable_id)
    end

    def uploadable_id
      params[(params[:uploadable].singularize + "_id").to_sym]
    end

    def upload_params
    	params.require(:upload).permit(:image, :before, :after)
    end
end
