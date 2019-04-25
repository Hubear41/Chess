require_relative "board"
require_relative "human_player"

class Game
    attr_reader :board, :display, :current_player, :players

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { #make computer player later
            :player1 => HumanPlayer.new(:white, @display), 
            :player2 => HumanPlayer.new(:black, @display)
        } 
        @current_player = :white
    end

    def play
        begin
            until @board.checkmate?(current_player)
                display.render(display.cursor)
                current_player.make_move
                display.render(display.cursor)
                
                notify_players
                swap_turn!
            end
            
        rescue => exception
            puts exception.message
            retry
        end

        display.render(display.cursor)
        puts "#{current_player} is checkmated"
    end

    private

    def notify_players
        puts "Its #{current_player}'s turn"
    end

    def swap_turn!
        @current_player = current_player == :white ? :black : :white
    end
end

if $PROGRAM_NAME == __FILE__
    Game.new.play
end

