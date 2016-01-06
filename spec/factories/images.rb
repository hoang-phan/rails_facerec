FactoryGirl.define do
  factory :image do
    binary_data File.read(Rails.root.join('spec', 'fixtures', 'example.jpg'))
    person_name { Faker::Name.name }
  end
end
