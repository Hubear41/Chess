require_relative "board"
require_relative "human_player"

class Game
    def initialize
        @board = Board.new
        @display = Display.new
        @players = {:player1 => HumanPlayer.new(:white, @display), :player2 => HumanPlayer.new(:black, display)} #make computer player later
        @current_player = @players[:player1]
    end

    def play
        begin
            until board.checkmate?(:white) || board.checkmate?(:black)
                @display.render
                @current_player.make_move
                @display.render
                
                notify_players
                swap_turn!
            end
        rescue => exception
            puts exception.message
            retry
        end

        ### print out a message for who wins ###
    end

    private

    def notify_players
        puts "Its #{@current_player.color}'s turn"
    end

    def swap_turn!
        if current_player == @players[:player1]
            @current_player = @players[:player2]
        else
            @current_player = @players[:player1]
        end
    end

end