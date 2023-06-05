require_relative './player'
require_relative './winning_conditions'
require 'set'

class Game 
  include WinningConditions
  attr_accessor :grid, :player1, :player2, :mode, :game_won

  def initialize(grid = Array.new(6) { Array.new(7, '⚫️') })
    @grid = grid
  end

  def game_won?(player)
    if result = winning_sequences.any? { |s| s.subset?(player.choices)}
      print "#{player.name} won!\n"
    end
    result
  end

  def display_grid
    clear_screen
    print "1 2 3 4 5 6 7\n"
    @grid.each do
      |row|
      print row.join("") + "\n"
    end
    @grid
  end

  def add_token(column, token)
    next_space = next_empty_space(column)
    return if valid_move?(column) == false
    @grid[5 - next_space][column] = token
  end

  def add_choice(column, player)
    next_space = next_empty_space(column)
    return if valid_move?(column) == false

    player.choices << number_grid[5 - next_space][column]
    puts player.choices
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

  def get_mode
    puts "Please select gameplay mode:
    1 - Vs Computer
    2 - Two-Player Mode"
    mode = gets.chomp
    if mode == '1'
      @mode = 1
      clear_screen
      puts 'Player 1, what is your name?'
      @player1 = Player.new('🔴')
      clear_screen
      @player2 = Player.new('⚪️', 1, 'Computer')
      display_grid
    elsif mode == '2'
      @mode = 2
      clear_screen
      puts 'Player 1, what is your name?'
      @player1 = Player.new('🔴')
      clear_screen
      puts 'Player 2, what is your name?'
      @player2 = Player.new('⚪️', 2)
      clear_screen
      display_grid
    else
      puts 'Invalid selection'
      get_mode
    end
  end

  def get_choice(player)
    move = player.get_choice
    if valid_move?(move)
      add_token(move, player.token)
      add_choice(move, player)
    else
      get_choice(player)
    end
  end

  def play_again_prompt
    puts 'Play again? (yes/no)'
    response = gets.chomp.downcase
    if %w[yes y].include?(response)
      new_game
    else
      exit
    end
  end

  def new_game
    game = Game.new
    game.play_game
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def play_game
    clear_screen
    get_mode
    until @game_won == true
      get_choice(player1)
      display_grid
      game_won?(player1) ? play_again_prompt : false
      get_choice(player2)
      display_grid
      game_won?(player2) ? play_again_prompt : false
    end
  end
end