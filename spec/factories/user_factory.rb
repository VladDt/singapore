FactoryGirl.define do
  factory :user do
    sequence(:full_name) { |i| "JustUser#{i}" }
    sequence(:phone_number) { |i| "#{i}" }
    encrypted_password 'dfsdfdk'
    sequence(:email) { |i| "user-#{i}@gmail.com" }
  end
end