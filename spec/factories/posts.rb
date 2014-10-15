# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    zip_code 1
    title "MyString"
    description "MyString"
    category nil
    user nil
    contractor nil
  end
end
