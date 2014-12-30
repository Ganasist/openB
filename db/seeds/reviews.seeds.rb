puts 'start reviews seed'

Review.delete_all

500.times do
  job = Job.all.sample
  if job.searching?
    job.contractor_id = Contractor.all.sample.pluck(:id)
    job.status = complete
    job.save!
    Review.create!(reviewable: job, reviewerable: job.user, quality: rand(11), cost: rand(11), timeliness: rand(11),
                    professionalism: rand(11), recommendation: rand(11))
  end
end

puts 'end reviews seed'
