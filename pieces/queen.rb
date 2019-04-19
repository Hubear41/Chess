require_relative "slidable.rb"
require_relative "piece.rb"

class Queen < Piece
    include Slidable

    def symbol
        :Queen
    end

    private 

     # lets slidable#moves know which deltas to use
    def move_dirs
        :both
    end
end