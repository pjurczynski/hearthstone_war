class Player
  include ActiveModel::Model
  attr_accessor :name, :available_cards, :played_card

  validates_presence_of :name, :available_cards

  def play_card
    self.played_card = available_cards.pop
  end
end
