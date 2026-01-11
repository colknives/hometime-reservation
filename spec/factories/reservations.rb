FactoryBot.define do
  factory :reservation do
    association :guest
    start_date { "2021-03-12" }
    end_date   { "2021-03-16" }
    status     { "accepted" }
    nights     { 4 }
    guests     { 4 }
    adults     { 2 }
    children   { 2 }
    infants    { 0 }
    currency   { "AUD" }
    payout_price { "3800.00" }
    security_price { "500" }
    total_price { "4500.00" }
  end
end
