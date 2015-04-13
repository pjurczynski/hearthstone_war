class GamesController < ApplicationController
  def new
    @game = Game.new
    available_cards = Card.all.sample(10)
    @game.player_1 = Player.new(
      available_cards: available_cards,
      played_card: DeadCard.new,
      next_card_id: available_cards.first.id
    )

    available_cards = Card.all.sample(10)
    @game.player_2 = Player.new(
      name: 'Nexus Computer',
      available_cards: available_cards,
      played_card: DeadCard.new,
      next_card_id: available_cards.first.id
    )
  end

  def create
    load_world
    render :edit
  end

  def update
    load_world
    @game.round_start
    @game.round_finish

    if @game.winner
      if @game.winner == :draw
        flash[:notice] = 'It was a draw!'
      else
        flash[:notice] = "#{@game.winner} won!"
      end
      redirect_to new_game_path
    else
      render :edit
    end
  end

  private

  def load_world
    @player_1 = Player.new(player_1_params)
    @player_2 = Player.new(player_2_params)
    @game = Game.new(player_1: @player_1, player_2: @player_2, id: :current)
  end

  def game_params
    params.require(:game)
  end

  def player_1_params
    game_params.require(:player_1).permit(
      %i(
        name
        available_cards
        next_card_id
      )
    ).merge(
      played_card: played_card(game_params[:player_1][:played_card]),
      available_cards: available_cards(game_params[:player_1][:available_cards])
    )
  end

  def player_2_params
    game_params.require(:player_2).permit(
      %i(
        name
        available_cards
        next_card_id
      )
    ).merge(
      played_card: played_card(game_params[:player_2][:played_card]),
      available_cards: available_cards(game_params[:player_2][:available_cards])
    )
  end

  def played_card(param)
    parsed = JSON.parse(param)
    if parsed.present?
      Card.new(parsed)
    else
      DeadCard.new
    end
  end

  def available_cards(param)
    Card.where(id: param.split(','))
  end
end
