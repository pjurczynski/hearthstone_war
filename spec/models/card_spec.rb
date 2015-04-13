require 'rails_helper'

describe Card do
  it { is_expected.to belong_to :deck }

  describe "#deal_damage" do
    subject { your_card }
    let(:your_card) { build :card }
    let(:opponents_card) { build :card }

    it 'hurts opponents card' do
      expect{ subject.deal_damage(opponents_card) }
        .to change{ opponents_card.health }.by(-subject.attack)
    end
  end

  describe "#dead?" do
    let(:card) { build :card }

    context "health above 0" do
      it "is alive" do
        expect(card.dead?).to be_falsey
      end
    end

    context "health 0" do
      it "is dead" do
        card.health = 0
        expect(card.dead?).to be_truthy
      end
    end

    context "health below 0" do
      it "is dead" do
        card.health = -1
        expect(card.dead?).to be_truthy
      end
    end
  end
end
