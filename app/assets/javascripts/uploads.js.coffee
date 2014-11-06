$(document).ready ->
  
  # disable auto discover
  Dropzone.autoDiscover = false
  
  # grap our upload form by its id
  $("#new_upload").dropzone
    
    # restrict image size to a maximum 3MB
    maxFilesize: 3

    maxFiles: 5
    
    # changed the passed param to one accepted by
    # our rails app
    paramName: "upload[image]"

    acceptedFiles: "image/png,image/jpg,image/jpeg"

    parallelUploads: 5
    
    # show remove links on each image upload
    addRemoveLinks: true
    
    # if the upload was successful
    success: (file, response) ->
      
      # find the remove button link of the uploaded file and give it an id
      # based of the fileID response from the server
      $(file.previewTemplate).find(".dz-remove").attr("id", response.fileID)
      
      # add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success")
      return

    
    #when the remove button is clicked
    removedfile: (file) ->
      
      # grap the id of the uploaded file we set earlier
      id = $(file.previewTemplate).find(".dz-remove").attr("id")
      
      # make a DELETE ajax request to delete the file
      $.ajax
        type: "DELETE"
        url: "/uploads/" + id
        success: (data) ->
          console.log data.message
          return
      return
  return
