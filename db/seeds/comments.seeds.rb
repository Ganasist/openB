
puts 'start comments seed now'

500.times do |u|
	commentable = %w(Job User Contractor Example).sample.constantize.all.sample
	commenterable = %w(User Contractor).sample.constantize.all.sample
	Comment.create!(subject: Faker::Name.title,
										 body: Faker::Lorem.paragraph(4, true, 4),
										 commentable_id: commentable.id,
										 commentable_type: commentable.class,
										 commenterable_id: commenterable.id,
										 commenterable_type: commenterable.class)
end

puts 'end comments seed now'
