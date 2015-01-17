json.upload do |json|
  if member.upload
    json.(member.upload, :id, :image_file_name, :before, :after)
    json.url member.upload.image.url
  end
end
