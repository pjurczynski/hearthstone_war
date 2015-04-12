class Round
  include ActiveModel::Model
  attr_accessor :player_1, :player_2

  validates_presence_of :player_1, :player_2

  def initialize(attributes = {})
    super
    self.finished = attributes.fetch(:finished) { true }
  end

  def start
    return false unless finished?
    all_players.each(&:play_card)
    self.finished = false
  end

  def finish
    return true if finished?
    player_1.deal_damage(player_2)
    player_2.deal_damage(player_1)
    self.finished = true
  end

  def finished?
    finished
  end

  private

  attr_accessor :finished

  def all_players
    Set.new([player_1, player_2])
  end
end
