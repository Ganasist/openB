json.user @user

json.contractor_feed @contractor_feed

json.partial! 'api/v1/uploads/member_upload', member: @user if @user.upload

json.partial! partial: 'api/v1/jobs/job', collection: @jobs if @jobs

json.partial! partial: 'api/v1/bids/bids', collection: @bids if @bids

json.reviews @reviews if @reviews
