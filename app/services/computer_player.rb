class ComputerPlayer
  def self.updated_board_state(game)
    # TODO: use ComputerMove here
    selected_place = game.board.available_cells.sample
    game.board.place_marker(game.computer, selected_place)
    return game
  end
end
