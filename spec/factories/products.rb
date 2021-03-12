FactoryBot.define do
  factory :product do
    product_name     {'商品名'}
    description      {Faker::Lorem.sentence}
    category_id      {2}
    condition_id     {2}
    delivery_fee_id  {2}
    prefecture_id    {2}
    delivery_date_id {2}
    price            {3000}
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
