# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "MyString"
    description "MyText"
    zip_code 1
    user nil
    contractor nil
  end
end
