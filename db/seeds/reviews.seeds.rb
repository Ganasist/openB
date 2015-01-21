puts 'start reviews seed'

Review.delete_all

500.times do
  bid = Bid.all.sample
  if bid.job.searching?
    bid.job.activate!(bid)
    bid.job.mark_as_complete
    bid.job.save!
    Review.create!(reviewable: bid.job, reviewerable: bid.job.user, quality: rand(11), cost: rand(11), timeliness: rand(11),
                    professionalism: rand(11), recommendation: rand(11))
  end
end

puts 'end reviews seed'
