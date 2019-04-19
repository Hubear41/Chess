require_relative "board"


class Game
    def initialize
        @board = Board.new
        @display = Display.new
        @players = {:player1 => HumanPlayer.new, :player2 => ComputerPlayer.new}
        @current_player = :player1
    end

    def play

    end

    private

    def notify_players

    end

    def swap_turn!

    end

end