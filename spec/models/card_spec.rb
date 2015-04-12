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
end
