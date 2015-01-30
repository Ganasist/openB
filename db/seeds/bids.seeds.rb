puts 'start bids seed'

Bid.delete_all

# class << self
#   def bid_check(job)
#     loop do
#       contractor = Contractor.all.sample
#       break contractor.id unless Bid.exists?(job_id: job.id, contractor_id: contractor.id)
#     end
#   end
# end

index = 0

1000.times do
  job = Job.order("RANDOM()").limit(1)
  loop do
    contractor = Contractor.order("RANDOM()").limit(1)
    unless Bid.exists?(job_id: job.id, contractor_id: contractor.id)
      Bid.create!(job_id: job.id,
                  contractor_id: contractor.id,
                  cost: rand(10..1000).round(-1))
    end
    break
  end
  index += 1
  puts "Index: #{ index }"
end

puts 'end bids seed'
