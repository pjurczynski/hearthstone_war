class Game
  include ActiveModel::Model
  attr_accessor :player_1, :player_2

  validates_presence_of :player_1, :player_2
end
