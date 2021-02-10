class GameController < ApplicationController

  def new
    # TODO: take input from user
    @game = Game.setup
  end

  def move
    @game = Game.find(params[:id])
    position = params[:position].to_i
    @game.board = Board.new(size: 3, cells: board_params) # TODO: do not hardcode size

    if ! @game.board.is_valid_input?(position)
      render json: { message: 'nvalid move' }, status: bad_request
    else
      player = @game.current_player

      if @game.computer?(player)
        @game = ComputerPlayer.updated_board_state(@game) unless @game.board.over?
      else
        @game.board.place_marker(player, position)
      end

      render json: GameState.format(@game)
    end
  end

  private

  def board_params
    params[:board].map { |c| c.empty? ? nil : c }
  end
end