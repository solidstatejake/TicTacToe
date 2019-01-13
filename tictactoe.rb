class Game
  attr_accessor :winner, :player1, :player2, :gameboard

  def initialize(player1_name, player2_name)
    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
    @winner = nil
    @gameboard = GameBoard.new(self, @player1, @player2)
  end

  def prompt_move(which_player)
    if which_player == @player1
      print "Make a move #{@player1.name}: "
    else
      print "Make a move #{@player2.name}: "
    end
  end

  def valid?(move)
    if @player1.moves.include?(move) || @player2.moves.include?(move) &&
       (0 < move && move <= 9)
      false
    else
      true
    end
  end

  def player1_turn
    move = nil
    @gameboard.display
    prompt_move(@player1)
    loop do
      move = gets.chomp.to_i
      break if valid? move
    end
    @player1.make(move)
    @gameboard.update(@player1)
    @player1.turn += 1
    @winner = check_winner
  end

  def player2_turn
    move = nil
    @gameboard.display
    prompt_move(@player2)
    loop do
      move = gets.chomp.to_i
      break if valid? move
    end
    @player2.make(move)
    @gameboard.update(@player2)
    @player2.turn += 1
    @winner = check_winner
  end

  # TODO: Figure out how to check for winner.
  def check_winner
    return nil if @player1.turn < 3

    winners = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
               [1, 4, 7], [2, 5, 8], [3, 6, 9],
               [1, 5, 9], [3, 5, 7]]

    0...8.times do |index|
      regex = Regexp.new "[#{winners[index].join.to_i}]{3}"
      if @player1.moves.join.match?(regex)
        @winner = @player1
      elsif @player2.moves.join.match?(regex)
        @winner = @player2
      end
    end
  end



  def play

    loop do
      loop do
        player1_turn
        check_winner
        break if winner
        player2_turn
        check_winner
        break if winner
      end
      puts "Congratulations, #{winner.name}! You've kicked TicTacToe ass!
  Would you like to play again? [y/n]"
      play_again = gets.chomp
      break if play_again == 'n'
      reset
    end
  end

  def reset
    @gameboard.reset
    @player1.reset
    @player2.reset
    @winner = nil
  end

  class Player
    attr_accessor :name, :game_piece, :moves, :turn

    def initialize(name, game_piece)
      @name = name
      @game_piece = game_piece
      @moves = []
      @turn = 0
    end

    def make(move)
      @moves.push(move)
    end

    def reset
      @moves = []
      @turn = 0
    end
  end


  class GameBoard
    attr_accessor :current, :player1, :player2
    attr_reader :game


    def initialize(game, player1, player2)

      @current = [['1', '2', '3'],
                  ['4', '5', '6'],
                  ['7', '8', '9']]
      @current_lookup = { 1 => '@current[0][0]',
                          2 => '@current[0][1]',
                          3 => '@current[0][2]',
                          4 => '@current[1][0]',
                          5 => '@current[1][1]',
                          6 => '@current[1][2]',
                          7 => '@current[2][0]',
                          8 => '@current[2][1]',
                          9 => '@current[2][2]' }
      @game = game
      @player1 = player1
      @player2 = player2
    end


    def update(player)
      move = if player == @player1
               @game.player1.moves[@game.player1.turn]
             else
               @game.player2.moves[@game.player2.turn]
             end

      eval("#{@current_lookup[move]} = 'X'") if player == @game.player1
      eval("#{@current_lookup[move]} = 'O'") if player == @game.player2
    end

    def display
      0...3.times do |m|
        0...3.times do |n|
          print " #{@current[m][n]} "
          print '|' unless n == 2
          print "\n---+---+---\n" if n == 2 && m != 2
        end
        print "\n" if m == 2
      end
    end

    def reset
      @current = [['1', '2', '3'],
                  ['4', '5', '6'],
                  ['7', '8', '9']]
      @current_lookup = { 1 => '@current[0][0]',
                          2 => '@current[0][1]',
                          3 => '@current[0][2]',
                          4 => '@current[1][0]',
                          5 => '@current[1][1]',
                          6 => '@current[1][2]',
                          7 => '@current[2][0]',
                          8 => '@current[2][1]',
                          9 => '@current[2][2]' }
    end

  end # End Gameboard class

end



