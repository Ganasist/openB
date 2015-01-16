json.contractors @contractors do |contractor|
  json.id             contractor.id
  json.created_at     contractor.created_at
  json.updated_at     contractor.updated_at
  json.email          contractor.email
  json.address        contractor.address
  json.fullname       contractor.fullname
  json.description    contractor.description
  json.categories     contractor.categories
  json.search_radius  contractor.search_radius
end
