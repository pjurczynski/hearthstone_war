class Game
  include ActiveModel::Model
  attr_accessor :player_1, :player_2, :id

  validates_presence_of :player_1, :player_2

  delegate :start, :finish, :finished?, to: :round, prefix: true

  def initialize(attributes = {})
    super(attributes)
    self.round = new_round
  end

  def winner
    return nil unless finished?
    all_players.find(&:has_cards?).try(:name) || :draw
  end

  def finished?
    not(all_players.all?(&:has_cards?))
  end

  private


  attr_accessor :round

  def all_players
    Set.new([player_1, player_2])
  end

  def new_round
    Round.new(player_1: player_1, player_2: player_2)
  end
end
