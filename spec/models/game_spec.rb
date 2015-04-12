require 'rails_helper'

describe Game do
  it { is_expected.to validate_presence_of :player_1 }
  it { is_expected.to validate_presence_of :player_2 }

  context "game of computer against you" do
    subject { game }

    let(:game) { described_class.new(player_1: computer, player_2: you) }
    let(:computer) { build(:player, :computer) }
    let(:you) { build(:player, :you) }

    describe "#start_round" do
      it { expect{ subject.start_round }.to change{ computer.played_card } }
      it { expect{ subject.start_round }.to change{ computer.available_cards.count }.by(-1) }

      it { expect{ subject.start_round }.to change{ you.played_card } }
      it { expect{ subject.start_round }.to change{ you.available_cards.count }.by(-1) }

      it { expect{ subject.start_round }.to change{ subject.round_finished? }.to(false) }
    end

    context "the round has been played" do
      before { subject.start_round }

      describe "#finish_round" do
        it "attacks computers card" do
          expect{ subject.finish_round }
            .to change{ computer.played_card.health }.by(-you.played_card.attack)
        end

        it "attacks your card" do
          expect{ subject.finish_round }
            .to change{ you.played_card.health }.by(-computer.played_card.attack)
        end

        it { expect{ subject.finish_round }.to change{ subject.round_finished? }.to(true) }
      end
    end
  end
end
