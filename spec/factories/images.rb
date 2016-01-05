FactoryGirl.define do
  factory :image do
    binary_data File.read(Rails.root.join('spec', 'fixtures', 'example.jpg'))

    association :person
  end
end
