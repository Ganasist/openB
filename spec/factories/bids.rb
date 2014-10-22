# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bid do
    jobs nil
    contractors nil
    cost 1
    duration 1
    duration_unit "MyString"
    accepted false
  end
end
