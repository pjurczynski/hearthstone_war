require 'rails_helper'

describe Player do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :available_cards }

  context "valid player" do
    subject { player }

    let(:player) { build(:player) }

    describe "#play_card" do
      it { expect{ subject.play_card }.to change{ player.played_card } }
      it { expect{ subject.play_card }.to change{ player.available_cards.count }.by(-1) }

      context "already played a card" do
        before { subject.play_card }

        it "doesn't draw a new card" do
          expect{ subject.play_card }.not_to change{ player.available_cards.count }
          expect{ subject.play_card }.not_to change{ player.played_card }
        end
      end

      context "has no more cards" do
        before { subject.available_cards = [] }

        it "plays with dead cards" do
          subject.play_card
          expect(subject.played_card.dead?).to be_truthy
        end
      end
    end

    describe "#has_cards?" do
      context "has some available cards" do
        it { expect(subject.has_cards?).to be_truthy }
      end

      context "have no cards left" do
        before { subject.available_cards = [] }

        it { expect(subject.has_cards?).to be_falsey }

        context "has a card on hand" do
          before { subject.played_card = build(:card) }
          it { expect(subject.has_cards?).to be_truthy }
        end
      end
    end
  end
end
