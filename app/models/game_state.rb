class GameState
  def self.format(game, player_turn = true)
    next_turn = game.board.over? ? nil : game.current_player
    winner = game.board.over? ? game.board.winner : nil

    return {
      id: game.id,
      game_over: game.board.over?,
      computer_marker: game.computer,
      next_turn: next_turn,
      winner: winner,
      board: game.board.cells
    }
  end
end
