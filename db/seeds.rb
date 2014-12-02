puts 'start seed here'

User.delete_all
Contractor.delete_all
Job.delete_all
Example.delete_all

zips = JSON.parse(File.read(Rails.root.join('valid-zips.json')))

50.times do |u|
	user = User.create!(email: Faker::Internet.email,
											password: 'loislane',
											password_confirmation: 'loislane',
											name: Faker::Name.name,
											categories: Contractor.categories.sample(rand(3) + 1).sort,
											zip_code: zips.sample
										 )

	contractor = Contractor.create!(email: Faker::Internet.email,
																 password: 'loislane',
																 password_confirmation: 'loislane',
																 name: Faker::Name.name,
																 description: Faker::Lorem.paragraph(4, true, 4),
																 company_name: Faker::Company.name,
																 categories: Contractor.categories.sample(rand(3) + 1).sort,
																 zip_code: User.all.sample.zip_code
																 )

	rand(20).times do |j|
		job = Job.create(user_id: user.id,
								contractor_id: [contractor.id, nil].sample,
								title: Faker::Name.title, 
								description: Faker::Lorem.paragraph(4, true, 4),
								zip_code: user.zip_code,
								categories: user.categories.sample(rand(3) + 1).sort
							 )
		job.save!
	end


	rand(20).times do |j|
		example = Example.create(contractor_id: contractor.id,
										title: Faker::Name.title, 
										description: Faker::Lorem.paragraph(4, true, 4),
										zip_code: contractor.zip_code,
										categories: contractor.categories.sample(rand(3) + 1).sort
									 )
		example.save!
	end
end

puts 'end seed here'
