FactoryGirl.define do
  factory :todo do
    title { Forgery::LoremIpsum.title }
    description  { Forgery::LoremIpsum.words }
  end
 end