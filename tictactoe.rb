module TicTacToe
    class Player
        attr_reader :piece, :id

        def initialize(piece, id)
            @piece = piece
            @id = id
        end
    end

    class Board
        attr_reader :gameboard

        def initialize
            @gameboard = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        end

        def update(move, piece)
            @gameboard[move] = piece
        end

        def draw
            puts ""
            puts " #{@gameboard[0]} | #{@gameboard[1]} | #{@gameboard[2]} "
            puts "-----------"
            puts " #{@gameboard[3]} | #{@gameboard[4]} | #{@gameboard[5]} "
            puts "-----------"
            puts " #{@gameboard[6]} | #{@gameboard[7]} | #{@gameboard[8]} "
            puts ""
        end
    end

    class Game
        WINNING_COMBOS = [[1, 2, 3], [1, 4, 7], [1, 5, 9],
                           [2, 5, 8], [3, 5, 7], [3, 6, 9],
                           [4, 5, 6], [7, 8, 9]]
        
        def initialize
            @board = Board.new
            @player1 = Player.new("X", 1)
            @player2 = Player.new("O", 2)

            puts "Welcome to Tic-Tac-Toe!"
            puts ""
            puts "To play, just select the number of the space you want to make your mark in!"
        end

        def gameplay
            player = @player1

            @board.draw

            loop do
                turn(player)

                if win?(player) || tie?
                    puts "Would you like to play again? [Y/N]"

                    play = gets.chomp

                    until ["y", "yes", "n", "no"].include? play.downcase
                        puts "Please answer yes or no."
                        play = gets.chomp
                    end

                    if ["y", "yes"].include? play.downcase
                        @board = Board.new
                        gameplay
                    elsif ["n", "no"]
                        puts "Thanks for playing! See you soon!"
                        exit
                    else
                        puts "Uhhhh, something went wrong. Abort!"
                        exit
                    end
                end

                player == @player1 ? player = @player2 : player = @player1                
                end
            end

        def turn(player)
            puts "Player #{player.id}'s turn!"
            puts "Where do you move?"
            move = gets.chomp.to_i

            if @board.gameboard.include? move
                move -=1
                @board.update(move, player.piece)
                @board.draw
            else
                puts "\nYou can't move there!\n\n"
                turn(player)
            end
        end

        def win?(player)
            game_won = false

            WINNING_COMBOS.each do |combo|
                in_a_row = 0

                combo.each do |space|
                    if @board.gameboard[space - 1] == player.piece
                        in_a_row += 1
                    else
                        break
                    end
                end

                if in_a_row == 3
                    puts "Player #{player.id} wins! Congratulations!"
                    return game_won = true
                end
            end

            game_won
        end

        def tie?
            if @board.gameboard.all? {|space| space == "X" || space == "O"}
                puts "No moves left! It's a tie!"
                return true
            else
                return false
            end
        end
    end
end

include TicTacToe

tictactoe = Game.new

tictactoe.gameplay