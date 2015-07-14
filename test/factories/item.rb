FactoryGirl.define do
  factory :item do
    sequence(:name) {|i| "Thing#{i}"}
    price "2"
    seller {create :user}
  end
end