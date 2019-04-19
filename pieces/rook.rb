require_relative "slidable.rb"
require_relative "piece.rb"

class Rook < Piece
    include Slidable

    def symbol
        :Rook
    end

    private

    # lets slidable#moves know which deltas to use
    def move_dirs
        :horizontal
    end
end