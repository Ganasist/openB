$(document).ready ->

  # disable auto discover
  Dropzone.autoDiscover = false

  # grab our upload form by its id
  $("#new_upload").dropzone

    # restrict image size to a maximum 3MB and number of files to 4
    maxFilesize: 3
    maxFiles: 4

    # changed the passed param to one accepted by
    # our rails app
    paramName: "upload[image]"

    acceptedFiles: "image/png,image/jpg,image/jpeg"

    parallelUploads: 4

    # show remove links on each image upload
    addRemoveLinks: true

    error: (file, XMLHttpRequest, xhr) ->
      console.log('An error has occured:')
      console.log(XMLHttpRequest)
      console.log(xhr)

    complete: (file) ->
      console.log('Upload complete')

    # if the upload was successful
    success: (file, response) ->
      console.log(response.fileID)

      # find the remove button link of the uploaded file and give it an id
      # based of the fileID response from the server
      $(file.previewTemplate).find(".dz-remove").attr("id", response.fileID)

      # add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success")
      # return

    #when the remove button is clicked
    removedfile: (file) ->
      # grab the id of the uploaded file we set earlier
      id = $(file.previewTemplate).find(".dz-remove").attr("id")

      if id != undefined
        console.log('Is not undefined')
        $(file.previewElement).removeClass("dz-success").addClass("dz-error")
        $(file.previewElement).fadeOut(1000)

        # make a DELETE ajax request to delete the file
        $.ajax
          type: "POST"
          url: "/uploads/" + id
          dataType: "json"
          data: { "_method":"delete" }
          success: (data) ->
            console.log data
            console.log data.fileID
          error: (data, error) ->
            alert('Some of your images could not be removed. Please erase them manually from your profile page.')
            console.log data
      else
        console.log 'Removing failed upload for ' + id
        $(file.previewElement).fadeOut(1000)
