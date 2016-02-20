FactoryGirl.define do
  factory :snippet do
    kind "MyString"
    title "MyString"
    code "MyText"
    private false
    user nil
  end
end
