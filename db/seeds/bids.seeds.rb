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

1000.times |b| do
  job = Job.all.sample
  loop do
    contractor = Contractor.all.sample
    unless Bid.exists?(job_id: job.id, contractor_id: contractor.id)
      Bid.create!(job_id: job.id,
                  contractor_id: contractor.id,
                  cost: rand(10..1000).round(-1))
    end
    break
  end
  puts "End of bid loop #{ b }"
end

puts 'end bids seed'
