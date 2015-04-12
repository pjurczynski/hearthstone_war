FactoryGirl.define do
  factory :game do
    player_1
    player_2
    initialize_with { new(player_1: player_1, player_2: player_2) }
  end
end

