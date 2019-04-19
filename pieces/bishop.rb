require_relative "slidable.rb"
require_relative "piece.rb"


class Bishop < Piece
    include Slidable

    def symbol
        :Bishop
    end

    private

    # lets slidable#moves know which deltas to use
    def move_dirs
        :diagonal
    end
end