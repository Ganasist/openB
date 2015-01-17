json.user @user

json.partial! 'api/v1/uploads/member_upload', member: @user

json.partial! partial: 'api/v1/jobs/job', collection: @jobs

json.reviews @reviews if @reviews
