json.contractor  @contractor

json.partial! 'api/v1/uploads/member_upload', member: @contractor

json.current_jobs @current_jobs
json.job_feed @job_feed

json.partial! partial: 'api/v1/bids/bids', collection: @bids if @bids

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
    json.image     upload.image.url
  end
end
