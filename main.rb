require './tictactoe.rb'

def intro_to_user
  puts "Let's play Tic-Tac-Toe!"
  puts "The first player to enter their name will go first. The player to
go first always plays as X's. The first player to place three of their pieces
in a row (whether horizontal, vertical, or diagonal) wins!\n\n"
  puts "The gameboard will consist, in the beginning, of numbers. These numbers
represent choices for when you make a move (i.e. you want to place a piece in
the upper left corner, you would choose '1' as your move). As moves are made,
these numbers will be replaced with the players' respective pieces. You can't
move where a piece has already been placed! Have fun!\n\n"
end

def grab_player_names
  puts 'Enter a name for player 1: '
  player1 = gets.chomp
  puts 'Enter a name for player 2: '
  player2 = gets.chomp

  [player1, player2]
end


intro_to_user

game = Game.new(*grab_player_names)

game.play
puts "Goodbye!"

