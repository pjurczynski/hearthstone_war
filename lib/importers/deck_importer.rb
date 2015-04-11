class DeckImporter
  attr_reader :cards, :deck_name

  MINION_TYPE = "Minion"
  PERMITTED_CARD_PARAMS = %i(
    name
    card_type
    cost
    description
    flavor
    attack
    health
  ).freeze

  def initialize(deck_name, cards)
    @deck_name = deck_name
    @cards = cards
  end

  def import!
    deck = Deck.find_or_create_by(name: deck_name)
    deck.cards = minion_cards
    deck.save
    deck
  end

  private

  def minion_cards
    minion_cards_hash.map { |card| Card.new sanitize_card_params(card) }
  end

  def minion_cards_hash
    converted_cards.select { |card| card[:card_type] == MINION_TYPE }
  end

  def converted_cards
    cards.map { |card| convert_keys(card) }
  end

  def convert_keys(card)
    converted_card = card.map do |key, value|
      key = underscore_key(key)
      key = translate_key(key)
      [key, value]
    end
    Hash[converted_card]
  end

  def underscore_key(key)
    key.to_s.underscore.to_sym
  end

  def translate_key(key)
    {
      type: :card_type,
      text: :description,
    }.fetch(key) { key }
  end

  def sanitize_card_params(params)
    params.select { |key, value| PERMITTED_CARD_PARAMS.include? key }
  end
end
