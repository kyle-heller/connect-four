require 'set'

module WinningConditions
  ROWS = 6
  COLUMNS = 7
  WINNING_LENGTH = 4

  def number_grid
    number_grid = [
    [36, 37, 38, 39, 40, 41, 42],
    [29, 30, 31, 32, 33, 34, 35],
    [22, 23, 24, 25, 26, 27, 28],
    [15, 16, 17, 18, 19, 20, 21],
    [8,  9,  10, 11, 12, 13, 14],
    [1,  2,  3,  4,  5,  6,  7]]
  end

  # Generate horizontal winning sequences
  def horizontal_sequences
    horizontal_sequences = Set.new
    (0..ROWS-1).each do |row|
      (0..COLUMNS-WINNING_LENGTH).each do |col|
        sequence = Set.new((0..WINNING_LENGTH-1).map { |i| row * COLUMNS + col + i + 1 })
        horizontal_sequences << sequence
      end
    end
    horizontal_sequences
  end

  # Generate vertical winning sequences
  def vertical_sequences
    vertical_sequences = Set.new
    (0..ROWS-WINNING_LENGTH).each do |row|
      (0..COLUMNS-1).each do |col|
        sequence = Set.new((0..WINNING_LENGTH-1).map { |i| (row + i) * COLUMNS + col + 1 })
        vertical_sequences << sequence
      end
    end
    vertical_sequences
  end

  # Generate diagonal (bottom-left to top-right) winning sequences
  def diagonal_up_sequences
    diagonal_up_sequences = Set.new
    (0..ROWS-WINNING_LENGTH).each do |row|
      (0..COLUMNS-WINNING_LENGTH).each do |col|
        sequence = Set.new((0..WINNING_LENGTH-1).map { |i| (row + i) * COLUMNS + col + i + 1 })
        diagonal_up_sequences << sequence
      end
    end
    diagonal_up_sequences
  end

  # Generate diagonal (top-left to bottom-right) winning sequences
  def diagonal_down_sequences
    diagonal_down_sequences = Set.new
    (WINNING_LENGTH-1..ROWS-1).each do |row|
      (0..COLUMNS-WINNING_LENGTH).each do |col|
        sequence = Set.new((0..WINNING_LENGTH-1).map { |i| (row - i) * COLUMNS + col + i + 1 })
        diagonal_down_sequences << sequence
      end
    end
    diagonal_down_sequences
  end

  # Combine all winning sequences
  def winning_sequences
    sequences = Set.new
    sequences += horizontal_sequences
    sequences += vertical_sequences
    sequences += diagonal_up_sequences
    sequences += diagonal_down_sequences
    sequences
  end

  # Print the generated winning sequences
  # winning_sequences.each { |sequence| p sequence }
end

