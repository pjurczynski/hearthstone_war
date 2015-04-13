class Player
  include ActiveModel::Model
  attr_accessor :name, :available_cards, :played_card, :next_card_id

  validates_presence_of :name, :available_cards

  def initialize(attributes = {})
    @played_card = attributes.fetch(:played_card) { DeadCard.new }
    super(attributes)
  end

  def play_card
    return played_card unless has_cards?
    return played_card unless played_card.dead?
    @played_card = next_card
    @available_cards = available_cards.where.not(id: @played_card.id)
  end

  def deal_damage(opponent)
    played_card.deal_damage(opponent.played_card)
  end

  def has_cards?
    available_cards.any? || not(played_card.dead?)
  end

  def next_card
    available_cards.find_by(id: next_card_id) || available_cards.first
  end

  def next_card_id
    @next_card_id.to_i
  end
end
