class Player
  include ActiveModel::Model
  attr_accessor :name, :available_cards, :played_card

  validates_presence_of :name, :available_cards

  def play_card
    return self.played_card unless has_cards?
    return self.played_card unless played_card.dead?
    self.played_card = available_cards.pop
  end

  def has_cards?
    available_cards.any? || not(played_card.dead?)
  end
end
