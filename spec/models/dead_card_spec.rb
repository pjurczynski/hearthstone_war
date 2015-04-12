require 'rails_helper'

describe DeadCard do
  let(:card) { build(:card) }

  subject { DeadCard.new }

  describe "#dead?" do
    it { expect(subject.dead?).to be_truthy }
  end

  describe "#deal_damage" do
    it { expect{ subject.deal_damage(card) }.not_to change{ card.health } }
  end
end
