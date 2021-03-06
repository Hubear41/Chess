require_relative 'stepable.rb'
require_relative "piece.rb"

class Knight < Piece
    include Stepable

    KNIGHT_DIR = [
        [2,1],
        [1,2],
        [-2,1],
        [-1,2],
        [2,-1],
        [1,-2],
        [-1,-2],
        [-2,-1]
    ]

    def symbol
        "\u265E".encode('utf-8')
    end

    def move_diffs
        KNIGHT_DIR
    end
end