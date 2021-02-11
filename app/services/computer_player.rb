class ComputerPlayer
  def self.updated_board_state(game)
    computer_move = ComputerMove.new
    ai_decision = computer_move.negamax(game.board, game.player_1_marker, game.player_2_marker)
    game.board.place_marker(game.computer, ai_decision)
    return game
  end
end
