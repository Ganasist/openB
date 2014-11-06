class UploadsController < ApplicationController
  def new
    @member = current_user || current_contractor
  	@upload = @member.uploads.build
  end
 
  def create
    @member = current_user || current_contractor
  	@upload = @member.uploads.create(upload_params)
  	if @upload.save
  	  render json: { message: "success" }, :status => 200
  	else
  	  #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
  	  render json: { error: @upload.errors.full_messages.join(',')}, status: 400
  	end  		
  end

  def edit
    @member = current_user || current_contractor
  end

  def destroy
    @upload = Upload.find(params[:id])
    @member = @upload.uploadable
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Image was deleted' }
      format.js
      # format.json { render json: { message: 'File deleted from server' } }
    end
  end
 
  private
  def upload_params
  	params.require(:upload).permit(:image)
  end
end