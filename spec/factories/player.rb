FactoryGirl.define do
  factory :player do
    available_cards { Card.all.sample(10) }

    trait :computer do
      name 'Nexus'
    end

    trait :you do
      name 'Awesome Dude'
    end
  end
end

