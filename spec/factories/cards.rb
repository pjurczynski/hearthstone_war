FactoryGirl.define do
  factory :card do
    name "Dummy Card"
    card_type "Minion"
    cost 1
    description "Dummy Card for testing."
    flavor "Dummy Card Flavor"
    attack 1
    health 1
    deck
  end
end
