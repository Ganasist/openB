json.jobs @jobs do |job|
  json.id             job.id
  json.user_id        job.user_id
  json.created_at     job.created_at
  json.updated_at     job.updated_at
  json.title          job.title

  json.uploads job.uploads do |upload|
    next if upload.nil?
    json.id        upload.id
    json.filename  upload.image_file_name
    json.before    upload.before
    json.after     upload.after
    json.image     upload.image.url
  end

  json.bids job.bids if job.bids
end
