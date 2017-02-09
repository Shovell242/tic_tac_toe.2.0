class Player

	def initialize(args)
		@game_board = args.fetch(game_board)
	end

	def get_player_names
		puts "Player 1. Please enter your name"
		@player1 = gets.chomp
		puts "Player 2. Please enter your name"
		@player2 = gets.chomp
	end
end

class Symbol
end

class GameBoard

	BOARD = (1..9).to_a

	def display_board
		c = 0
		until c > 6
			puts BOARD[c..(c + 2)].join(" ")
			c += 3
		end
	end

	def place_symbol(position, symbol)
		BOARD[position] = symbol
	end
end

Player.new(game_board: GameBoard.new)


