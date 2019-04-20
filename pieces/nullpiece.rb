require 'singleton'

class NullPiece < Piece

    include Singleton
    attr_reader :color

    def symbol
        ' ''
    end

    def initialize
        @color = nil
    end

    # NullPiece doesn't have any moves 
    # pieces are expect to return a list of moves so we return []
    def moves
        []
    end

end