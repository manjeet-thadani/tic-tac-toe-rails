class ComputerMove
  def negamax(board, player1, player2, depth = 0)
    # TODO for 2nd turn too
    if board.empty? 
      return board.corners.sample
    elsif board.draw?
      return 0
    elsif board.over?
      return -10
    end

    scores = []

    board.available_cells.each do |cell|
      if board.available_cells.length.even?
        board.place_marker(player2, cell)
      else
        board.place_marker(player1, cell)
      end
      #if next player lost, current player has won, take opposite side of their score.
      score = -negamax(board, player1, player2, depth + 1)
      scores << [cell, score]
      board.reset_cell(cell)
    end

    if depth > 0
      scores.max_by {|cell, score| score}[1] #best score
    else
      scores.max_by {|cell, score| score}[0] #best move
    end
  end
end