class Game < ApplicationRecord
  attr_accessor :board

  def self.setup(size: 3, mode: 'computer')
    game = self.create
    game.player_1_type = 'human'
    game.player_2_type = mode == 'computer' ? 'computer' : 'human'
    game.player_1_marker = 'x' 
    game.player_2_marker = 'o'
    game.first_player = game.player_1_marker
    game.cells = Array.new(size * size)
    game.board = Board.new(size: size, cells: game.cells)

    game.save

    return game
  end

  def player_2
    self.first_player == 'x' ? 'o' : 'x'
  end

  def current_player
    self.board.available_cells.size.even? ? player_2 : self.first_player
  end

  def computer?(marker)
    (self.player_1_marker == marker && self.player_1_type == 'computer') || 
        (self.player_2_marker == marker && self.player_2_type == 'computer')
  end
  
  def computer
    return self.player_1_marker if self.player_1_type == 'computer'
    return self.player_2_marker if self.player_2_type == 'computer'
    return nil
  end
end
