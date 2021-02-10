class GameState
  def self.format(game, player_turn = true)
    next_turn = game.board.over? ? nil : @game.current_player

    return {
      id: game.id,
      game_over: game.board.over?,
      player_1_marker: game.player_1_marker,
      player_2_marker: game.player_2_marker,
      player_1_type: game.player_1_type,
      player_2_type: game.player_2_type,
      next_turn: next_turn,
      board: game.board.cells
    }
  end
end
