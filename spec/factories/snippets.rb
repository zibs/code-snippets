FactoryGirl.define do
  factory :snippet do
    association :user, factory: :user
    kind  { %w(Ruby HTML CSS JavaScript).sample }
    title { Faker::Hipster.words(3).join(" ") }
    code  { Faker::Shakespeare.hamlet_quote }
    private false
  end
end
