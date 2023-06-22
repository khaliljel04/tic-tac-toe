class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def choose(free_numbers)
    loop do
      puts "#{name}, make your move! \nChoose from 1-9:"
      move = gets.chomp.to_i
      return move if move.is_a?(Integer) && free_numbers.include?(move)
    end
  end
end

class Game
  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                          [1, 4, 7], [2, 5, 8], [3, 6, 9],
                          [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @players = [Player.new('Khalil', 'X'), Player.new('Yacine', 'O')]
    @current_player = @players[0]
    @next_player = @players[1]
    @board = %w[zero 1 2 3 4 5 6 7 8 9]
    @free_numbers = (1..9).to_a
  end

  def display_board
    system('clear')
    puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
    puts '---+---+---'
    puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
    puts '---+---+---'
    puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "
  end

  def turn
    player_move = @current_player.choose(@free_numbers)
    @board[player_move] = @current_player.marker
    @free_numbers.delete(player_move)
  end

  def switch_player
    @current_player, @next_player = @next_player, @current_player
  end

  def won?
    WINNING_COMBINATIONS.each do |comb|
      return true if @board[comb[0]] == @board[comb[1]] && @board[comb[1]] == @board[comb[2]]
    end
    false
  end

  def display_winner
    if won?
      puts "#{@current_player.name} has won!"
    else
      puts "It's a draw"
    end
  end

  def play
    display_board
    loop do
      turn
      display_board
      break if won? || @free_numbers.empty?

      switch_player
    end
    display_winner
  end
end

Game.new.play
