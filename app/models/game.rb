class Game < ApplicationRecord
  attr_accessor :board

  def self.setup_board(size = 3)
    game = self.create(board: Board.new(size: size))
    return game
  end

  def init(player_1_type = 'human', player_2_type = 'computer')
    self.player_1_type = player_1_type
    self.player_2_type = player_2_type

    self.player_1_marker = 'x' 
    self.player_2_marker = 'o'
    self.first_player = self.player_1_marker

    self.save
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
