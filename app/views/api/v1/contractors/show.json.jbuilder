json.contractor @contractor

json.partial! 'api/v1/uploads/member_upload', member: @contractor

json.partial! partial: 'api/v1/jobs/job', collection: @jobs

json.examples @examples do |example|
  json.id             example.id
  json.created_at     example.created_at
  json.updated_at     example.updated_at
  json.title          example.title
  json.uploads example.uploads do |upload|
    next if upload.nil?
    json.id        upload.id
    json.filename  upload.image_file_name
    json.before    upload.before
    json.after     upload.after
    json.image_url upload.image.url
  end
end
