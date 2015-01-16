json.user do
  json.id             @user.id
  json.created_at     @user.created_at
  json.updated_at     @user.updated_at
  json.email          @user.email
  json.address        @user.address
  json.fullname       @user.fullname
  json.categories     @user.categories
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

json.jobs @jobs do |job|
  json.id             job.id
  json.created_at     job.created_at
  json.updated_at     job.updated_at
  json.title          job.title
end

json.reviews @reviews do |review|
  json.id             review.id
  json.created_at     review.created_at
  json.updated_at     review.updated_at
end
