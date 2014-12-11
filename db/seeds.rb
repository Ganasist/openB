puts 'start seed here'

User.delete_all
Contractor.delete_all
Job.delete_all
Example.delete_all
Bid.delete_all


50.times do |u|
	user = User.create!(email: Faker::Internet.email,
											password: 'loislane',
											password_confirmation: 'loislane',
											name: Faker::Name.name,
											categories: Contractor.categories.sample(rand(3) + 1).sort,
											address: Faker::Address.street_address
										 )

	contractor = Contractor.create!(email: Faker::Internet.email,
																 password: 'loislane',
																 password_confirmation: 'loislane',
																 name: Faker::Name.name,
																 description: Faker::Lorem.paragraph(4, true, 4),
																 company_name: Faker::Company.name,
																 categories: Contractor.categories.sample(rand(3) + 1).sort,
																 address: Faker::Address.street_address
																 )

	rand(50).times do |j|
		job = Job.create(user_id: user.id,
		contractor_id: nil,
		title: Faker::Name.title,
		description: Faker::Lorem.paragraph(4, true, 4),
		categories: user.categories.sample(rand(3) + 1).sort
		)
		job.save!
	end

	rand(500).times do |u|
		Bid.create!(job_id: Job.pluck(:id).sample,
		contractor_id: Contractor.pluck(:id).sample,
		cost: rand(10..1000).round(-1))
	end

	Job.all.each do |j|
		j.bids.each do |b|
			j.contractor_id = b.contractor_id
		end
	end

	rand(20).times do |j|
		example = Example.create(contractor_id: contractor.id,
										title: Faker::Name.title,
										description: Faker::Lorem.paragraph(4, true, 4),
										categories: contractor.categories.sample(rand(3) + 1).sort
									 )
		example.save!
	end
end

puts 'end seed here'
