class Board
  attr_accessor :cells, :size
  
  def initialize(size: 3, cells: nil)
    @cells = cells.nil? ? Array.new(size * size) : cells
    @size = size
  end

  def rows
    @cells.each_slice(@size).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    left = []
    right = []
  
    (0..@size - 1).each do |position| 
      matrix = rows
      left << matrix[position][position]
      right << matrix[position][@size - position - 1]
    end
  
    return [left, right]
  end

  def corners
    matrix = rows
    return [matrix.first.first, matrix.first.last, matrix.last.first, matrix.last.last]
  end

  def full?
    @cells.all? { |i| !i.nil? }
  end

  def empty?
    @cells.all? { |i| i.nil? }
  end

  def draw?
    winner.nil? && full?
  end

  def over?
    !winner.nil? || draw?
  end

  def winner
    winner = nil
    rows.each do |row|
      if row.uniq.length == 1 && row.uniq.all?(&:nil?) == false
        winner = row.first
      end
    end

    columns.each do |column|
      if column.uniq.length == 1 && column.uniq.all?(&:nil?) == false
        winner = column.first
      end
    end

    diagonals.each do |diagonal|
      if diagonal.uniq.length == 1 && diagonal.uniq.all?(&:nil?) == false
        winner = diagonal.first
      end
    end

    return winner
  end

  def is_valid_input?(choice)
    available_cells.include?(choice)
  end

  def available_cells
    @cells.each_index.select { |i| @cells[i].nil? }
  end

  def place_marker(marker, index)
    @cells[index] = marker
  end

  def reset_cell(index)
    @cells[index] = nil
  end

end
