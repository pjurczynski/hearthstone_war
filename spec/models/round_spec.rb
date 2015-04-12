require 'rails_helper'

describe Round do
  it { is_expected.to validate_presence_of :player_1 }
  it { is_expected.to validate_presence_of :player_2 }

  context "round of computer against you" do
    subject { round }

    let(:round) { build(:round, player_1: computer, player_2: you) }
    let(:computer) { build(:player, :computer) }
    let(:you) { build(:player, :you) }

    it { expect(subject.finished?).to be_truthy }

    describe "#start" do
      it { expect{ subject.start }.to change{ computer.played_card } }
      it { expect{ subject.start }.to change{ computer.available_cards.count }.by(-1) }

      it { expect{ subject.start }.to change{ you.played_card } }
      it { expect{ subject.start }.to change{ you.available_cards.count }.by(-1) }

      it { expect{ subject.start }.to change{ subject.finished? }.to(false) }
    end

    context "the round has been started" do
      before { subject.start }

      describe "#finish" do
        it "attacks computers card" do
          expect{ subject.finish }
            .to change{ computer.played_card.health }.by(-you.played_card.attack)
        end

        it "attacks your card" do
          expect{ subject.finish }
            .to change{ you.played_card.health }.by(-computer.played_card.attack)
        end

        it { expect{ subject.finish }.to change{ subject.finished? }.to(true) }
      end
    end
  end
end
