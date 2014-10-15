json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :description, :zip_code, :user_id, :contractor_id
  json.url job_url(job, format: :json)
end
