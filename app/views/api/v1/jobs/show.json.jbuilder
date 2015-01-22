json.job @job
json.possible_actions @job.aasm.events.map(&:name)
json.bids @job.bids if @job.bids

json.job_images @job.uploads.each do |upload|
  next if upload.nil?
  json.id        upload.id
  json.image     upload.image.url
end
