require_relative "slidable.rb"
require_relative "piece.rb"

class Rook < Piece
    include Slidable

    def symbol
        "\u265C".encode('utf-8')
    end

    private

    # lets slidable#moves know which deltas to use
    def move_dirs
        :horizontal
    end
end