class Game < ApplicationRecord
  attr_accessor :board, :game

  def self.setup(size = 3, player_1_type = 'human', player_2_type = 'human')
    @game = self.create(board: Board.new(size: size))
    @game.player_1_type = player_1_type
    @game.player_2_type = player_2_type

    @game.player_1_marker = 'x' 
    @game.player_2_marker = 'o'
    @game.first_player = @game.player_1_marker

    return @game
  end

  def player_2
    @game.first_player == 'x' ? 'o' : 'x'
  end

  def current_player
    @game.board.available_cells.size.even? ? player2 : @game.first_player
  end

  def computer?(marker)
    (@game.player_1_marker = marker && @game.player_1_type == 'computer') || 
        (@game.player_2_marker = marker && @game.player_2_type == 'computer')
  end
  
  def computer
    return @game.player_1_marker if @game.player_1_type == 'computer'
    return @game.player_2_marker if @game.player_2_type == 'computer'
    return nil
  end
end
