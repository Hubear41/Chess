require_relative 'stepable.rb'
require_relative "piece.rb"

class King < Piece
    include Stepable

     KING_DIR = [
        [1,1],
        [1,0],
        [1,-1],
        [-1,0],
        [-1,-1],
        [0,-1],
        [-1,1],
        [0,1]
    ]  

    def symbol
        "\u265A".encode('utf-8')
    end

    def move_diffs
        KING_DIR
    end
end