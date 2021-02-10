class GameController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    # TODO: take input from user
    @game = Game.setup
  end

  def move
    game = Game.find(params[:id].to_i)
    position = params[:position].to_i
    
    game.board = Board.new(size: 3, cells: board_params) # TODO: do not hardcode size

    if ! game.board.is_valid_input?(position)
      render json: { message: 'nvalid move' }, status: bad_request
    else
      player = game.current_player
      if game.computer?(player)
        game = ComputerPlayer.updated_board_state(game) unless game.board.over?
      else
        game.board.place_marker(player, position)
      end

      render json: GameState.format(game)
    end
  end

  private

  def board_params
    params[:board].map { |c| c.empty? ? nil : c }
  end
end