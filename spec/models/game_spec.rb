require 'rails_helper'

describe Game do
  it { is_expected.to validate_presence_of :player_1 }
  it { is_expected.to validate_presence_of :player_2 }

  context "game of computer against you" do
    subject { game }

    let(:game) { build(:game, player_1: computer, player_2: you) }
    let(:computer) { build(:player, :computer) }
    let(:you) { build(:player, :you) }

    it { expect(subject.round_finished?).to be_truthy }

    describe "#winner" do
      context "computer has no more cards" do
        before { computer.available_cards = [] }

        it "announces you as a winner" do
          expect(subject.winner).to eq you.name
        end
      end

      context "you don't have more cards" do
        before { you.available_cards = [] }

        it "announces computer as a winner" do
          expect(subject.winner).to eq computer.name
        end
      end

      context "you both run out of cards" do
        before do
          computer.available_cards = []
          you.available_cards = []
        end

        it "announces a draw" do
          expect(subject.winner).to eq :draw
        end
      end
    end
  end
end
