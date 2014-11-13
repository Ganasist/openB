
puts 'start seed here'

50.times do |u|
	user = User.create!(email: Faker::Internet.email,
											password: 'loislane',
											password_confirmation: 'loislane',
											name: Faker::Name.name,
											categories: Contractor.categories.sample(rand(3) + 1).sort,
											zip_code: Faker::Address.zip_code.to_i
										 )

	contractor = Contractor.create!(email: Faker::Internet.email,
																 password: 'loislane',
																 password_confirmation: 'loislane',
																 name: Faker::Name.name,
																 description: Faker::Lorem.paragraph(4, true, 4),
																 company_name: Faker::Company.name,
																 categories: Contractor.categories.sample(rand(3) + 1).sort,
																 zip_code: Job.all.sample.zip_code
																 )

	rand(20).times do |j|
		Job.create!(user_id: user.id,
								contractor_id: [contractor.id, nil].sample,
								title: Faker::Name.title, 
								description: Faker::Lorem.paragraph(4, true, 4), 
								categories: user.categories,
								zip_code: user.zip_code
							 )
	end

	rand(20).times do |j|
		Example.create!(contractor_id: contractor.id,
										title: Faker::Name.title, 
										description: Faker::Lorem.paragraph(4, true, 4), 
										categories: contractor.categories,
										zip_code: contractor.zip_code
									 )
	end
end

puts 'end seed here'
