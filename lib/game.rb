require 'pry-byebug'

class Game 
  attr_accessor :grid
  def initialize(grid = Array.new(6) { Array.new(7, '⚫️') })
    @grid = grid
  end

  def display_grid
    @grid.each do
      |row|
      row.join('') + "\n"
    end
  end

  def add_token(column, token)
    next_space = next_empty_space(column)
    return if valid_move?(column) == false
    @grid[5 - next_space][column] = token
  end

  def next_empty_space(column, row = 0)
      if row <= 5 && @grid.reverse[row][column] == '⚫️'
        return row
      elsif row < 5
        next_empty_space(column, row + 1)
      end
  end

  def valid_move?(column)
    if @grid.reverse[5][column] != '⚫️'
      return false
    else
      return true
    end
  end

end

game = Game.new
game.grid= [
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"], 
  ["🔵", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️", "⚫️"]]

  game.next_empty_space(0)