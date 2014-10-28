# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :example do
    title "MyString"
    zip_code 1
    description "MyString"
    duration 1
    duration_unit "MyString"
    cost 1
    portfolio nil
  end
end
