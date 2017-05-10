FactoryGirl.define do
  factory :basket_product do
    quantity  { Faker::Number.between(1, 10) }
    basket
    product
  end
end
