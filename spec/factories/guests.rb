FactoryBot.define do
  factory :guest do
    email { Faker::Internet.unique.email }
    first_name { "Wayne" }
    last_name { "Woodbridge" }
    phone { "639123456789" }
  end
end
