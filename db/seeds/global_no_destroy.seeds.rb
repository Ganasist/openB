puts 'start Global No Destroy seed'

250.times do |u|
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

  rand(20).times do |j|
    job = Job.create(user_id: user.id,
    contractor_id: nil,
    title: Faker::Name.title,
    description: Faker::Lorem.paragraph(4, true, 4),
    categories: user.categories.sample(rand(3) + 1).sort
    )
    job.save!
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

puts 'end Global No Destroy seed'
