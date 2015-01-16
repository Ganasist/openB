json.contractor do
  json.id             @contractor.id
  json.created_at     @contractor.created_at
  json.updated_at     @contractor.updated_at
  json.email          @contractor.email
  json.address        @contractor.address
  json.fullname       @contractor.fullname
  json.description    @contractor.description
  json.categories     @contractor.categories
  json.search_radius  @contractor.search_radius
  json.upload do
    next if @contractor.upload.nil?
    json.id        @contractor.upload.id
    json.filename  @contractor.upload.image_file_name
    json.before    @contractor.upload.before
    json.after     @contractor.upload.after
    json.image_url @contractor.upload.image.url
  end
end

json.bids @bids do |bid|
  json.id             bid.id
  json.created_at     bid.created_at
  json.updated_at     bid.updated_at
  json.job_id         bid.job_id
  json.contractor_id  bid.contractor_id
  json.accepted       bid.accepted
  json.rejected       bid.rejected
  json.cost           bid.cost
end

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

json.jobs @jobs do |job|
  json.id             job.id
  json.created_at     job.created_at
  json.updated_at     job.updated_at
  json.title          job.title
  json.uploads job.uploads do |upload|
    next if upload.nil?
    json.id        upload.id
    json.filename  upload.image_file_name
    json.before    upload.before
    json.after     upload.after
    json.image_url upload.image.url
  end
end

json.reviews @reviews do |review|
  json.id             review.id
  json.created_at     review.created_at
  json.updated_at     review.updated_at
end
