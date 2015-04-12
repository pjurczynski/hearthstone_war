class Game
  include ActiveModel::Model
  attr_accessor :player_1, :player_2

  validates_presence_of :player_1, :player_2

  def start_round
    return false unless round_finished?
    all_players.each(&:play_card)
    self.round_finished = false
  end

  def round_finished?
    round_finished
  end

  private

  attr_accessor :round_finished

  def all_players
    Set.new([player_1, player_2])
  end
end
