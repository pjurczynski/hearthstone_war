class DecksController < ApplicationController
  respond_to :json

  def index
    @decks = Deck.includes(:cards).all
    respond_with @decks, include: :cards
  end

  def show
    @deck = Deck.find(params[:id])
    respond_with @deck, include: :cards
  end
end
