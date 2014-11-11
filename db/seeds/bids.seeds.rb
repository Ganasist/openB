
puts 'start bids seed now'

500.times do |u|
	Bid.create!(job_id: Job.pluck(:id).sample,
							contractor_id: Contractor.pluck(:id).sample, 
							cost: rand(10..1000).round(-1))
end

puts 'end bids seed now'
