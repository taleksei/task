FactoryGirl.define do
  factory :page do
    sequence(:name)  { |n| "Page_#{n}" }
    sequence(:title) { |n| "page #{n}"}
    content "content"
  end
end