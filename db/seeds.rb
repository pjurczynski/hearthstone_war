# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require Rails.root.join('lib', 'importers', 'deck_importer.rb')

hearthstone_decks_file = Rails.root.join('app', 'data', 'hearthstone_decks.json')

decks = JSON.parse hearthstone_decks_file.read

decks.each do |deck, cards|
  DeckImporter.new(deck, cards).import!
end
