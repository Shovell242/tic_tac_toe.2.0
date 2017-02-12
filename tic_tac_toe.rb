class Player
	attr_reader :player1, :player2

	def initialize
		get_player_names
	end

	def both_players
		[:player1, :player2]
	end

	def get_player_names
		puts "Player 1. Please enter your name"
		@player1 = gets.chomp
		puts "Player 2. Please enter your name"
		@player2 = gets.chomp
	end
end

class GamePieces
	attr_reader :player1, :player2

	def initialize(args = {})
		@player1 = args.fetch(:p1_symbol, "X")
		@player2 = args.fetch(:p2_symbol, "O")
	end
end

class GameBoard
	BOARD = (1..9).to_a
	WINNING_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

	def display_board
		c = 0
		until c > 6
			puts BOARD[c..(c + 2)].join(" ")
			c += 3
		end
	end

	def place_gamepiece(key, piece)
		BOARD[key - 1] = piece
	end

	def game_over
		winner? || draw?
	end

	private

	def winner?
		WINNING_COMBOS.each do |combos|
			return true if win_test(combos)
		end
		false
	end

	def win_test(array)
		arr = []
		array.each { |x| arr << BOARD[x] }
		arr.all? { |x| x == arr[0] }
	end

	def draw?
		BOARD.all? { |x| x.is_a? String }
	end
end

class PlayGame
	attr_reader :players, :game_board, :game_pieces

	def initialize(args)
		@players     = args.fetch(:players)
		@game_board  = args.fetch(:game_board)
		@game_pieces = args.fetch(:game_pieces)
		game_flow
	end

	def get_user_move(player)
		puts "#{player} please select the key you want to place your game piece on"
		key = gets.chomp.to_i
	end

	def game_flow
		catch :winner! do
			loop do
				players.both_players.each do |player|
					game_board.display_board
					game_board.place_gamepiece(get_user_move(players.send(player)), game_pieces.send(player))
					throw :winner! if game_board.game_over
				end
			end	
		end
	end
end

PlayGame.new(players: Player.new, game_board: GameBoard.new, game_pieces: GamePieces.new)


