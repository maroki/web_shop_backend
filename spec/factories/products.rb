FactoryGirl.define do
  factory :product do
    name      { SecureRandom.uuid }
    quantity  { Faker::Number.between(1, 100) }
    price     { Faker::Number.decimal(2) }
  end
end
