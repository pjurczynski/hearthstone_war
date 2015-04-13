class DeadCard
  include ActiveModel::Model
  def id
    nil
  end

  def name
    'Dead Card'
  end

  def card_type
    'Dead'
  end

  def cost
    0
  end

  def description
    'This card died'
  end

  def flavor
    'Deathly'
  end

  def attack
    0
  end

  def health=(val)
    0
  end

  def health
    0
  end

  def deck
    Deck.new(name: 'Dead Deck')
  end

  def deck_id
    nil
  end

  def dead?
    true
  end

  def deal_damage(card)
    card.health
  end

  def to_partial_path
    'cards/card'
  end
end
