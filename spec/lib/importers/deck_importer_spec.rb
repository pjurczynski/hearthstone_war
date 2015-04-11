require 'rails_helper'
require Rails.root.join('lib', 'importers', 'deck_importer.rb')

describe DeckImporter do
  after { Deck.find_by(name: deck_name).destroy }
  describe "#import" do
    let(:deck_name) { 'Testing Deck' }
    let(:cards) { [minion_params, spell_params] }

    let(:minion_params) do
      {
        "id"=>"EX1_066",
        "name"=>"Acidic Swamp Ooze",
        "type"=>"Minion",
        "faction"=>"Alliance",
        "rarity"=>"Common",
        "cost"=>2,
        "attack"=>3,
        "health"=>2,
        "text"=>"<b>Battlecry:</b> Destroy your opponent's weapon.",
        "flavor"=>"Oozes love Flamenco.  Don't ask.",
        "artist"=>"Chris Rahn",
        "collectible"=>true,
        "howToGetGold"=>"Unlocked at Rogue Level 57.",
        "mechanics"=>["Battlecry"],
      }
    end

    let(:spell_params) do
      {
        "id"=>"CS2_041",
        "name"=>"Ancestral Healing",
        "type"=>"Spell",
        "faction"=>"Neutral",
        "rarity"=>"Free",
        "cost"=>0,
        "text"=>"Restore a minion to full Health and give it <b>Taunt</b>.",
        "flavor"=>
        "I personally prefer some non-ancestral
         right-the-heck-now healing, but maybe that is just me.",
        "artist"=>"Dan Scott",
        "collectible"=>true,
        "playerClass"=>"Shaman",
        "howToGet"=>"Unlocked at Level 1.",
        "howToGetGold"=>"Unlocked at Level 15."
      }
    end

    context "a deck with valid and invalid cards" do
      subject { described_class.new(deck_name, cards) }

      it "creates a deck" do
        expect{ subject.import! }.to change{ Deck.count }.by(1)
      end

      it "doesn't create duplicates" do
        expect{ 2.times { subject.import! } }.to change{ Deck.count }.by(1)
      end

      it "imports only minions cards" do
        expect{ subject.import! }.to change{ Card.count }.by(1)
        expect(Card.last.name).to eq 'Acidic Swamp Ooze'
      end

      it "creates a deck with a name" do
        expect(subject.import!.name).to eq deck_name
      end

      it "creates a full card" do
        card = subject.import!.cards.first
        expect(card.name).to eq "Acidic Swamp Ooze"
        expect(card.card_type).to eq "Minion"
        expect(card.cost).to eq 2
        expect(card.attack).to eq 3
        expect(card.health).to eq 2
        expect(card.description).to eq "<b>Battlecry:</b> Destroy your opponent's weapon."
        expect(card.flavor).to eq "Oozes love Flamenco.  Don't ask."
      end
    end
  end
end
