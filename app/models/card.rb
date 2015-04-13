class Card < ActiveRecord::Base
  belongs_to :deck

  def deal_damage(card)
    card.health -= attack
  end

  def dead?
    health <= 0
  end
end
