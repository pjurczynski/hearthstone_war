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
    end
  end
end
