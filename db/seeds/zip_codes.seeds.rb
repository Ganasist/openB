unless Rails.env.staging?
	puts 'start zip codes seed'

	Search.delete_all

	zips = JSON.parse(File.read(Rails.root.join('valid-zips.json')))

	zips.each do |zip|
		Search.create!(zip_code: zip)
	end

	puts 'end zip codes seed'
end
