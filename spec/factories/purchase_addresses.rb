FactoryBot.define do
  factory :purchase_address do
    token        {'tok_abcdefghijk00000000000000000'}
    post_code    {'123-4567'}
    prefecture   {2}
    city         {'東京都'}
    address      {'1-1'}
    building     {'東京ハイツ'}
    phone_number {'09012345678'}
  end
end
