class GameController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @game = Game.new
  end

  def new
    id = params[:id]
    @game = Game.find(id)
    @game.board = Board.new
  end

  # POST /games
  def start
    # TODO: validate input data
    mode = params[:mode]

    @game = Game.setup_board
    @game.init(mode)

    redirect_to :action => 'new', id: @game.id
  end

  def move
    game = Game.find(params[:id].to_i)
    position = params[:position].to_i
    game.board = Board.new(size: 3, cells: board_params)

    if ! game.board.is_valid_input?(position)
      render json: { message: 'Invalid move' }, status: bad_request
    elsif game.computer?(game.current_player)
      render json: { message: 'Invalid! It is computer turn' }, status: :bad_request
    elsif game.board.over?
      render json: { message: 'Invalid! Game is over' }, status: :bad_request
    else
      player = game.current_player
      game.board.place_marker(player, position)

      if !game.board.over? && game.computer?(game.current_player)
        game = computer_move(game)
      end

      render json: GameState.format(game)
    end
  end

  private

  def computer_move(game)
    ComputerPlayer.updated_board_state(game) unless game.board.over?
  end

  def board_params
    params[:board].map { |c| c.empty? ? nil : c }
  end
end