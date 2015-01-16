json.images @images do |image|
  json.id         image.id
  json.filename   image.image_file_name
  json.image_url  image.image.url
  json.before     image.before
  json.after      image.after
end
