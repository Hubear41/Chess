class Piece
    attr_reader :pos, :color
    attr_accessor :board

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    # print the utf-8 symbol for the piece
    def to_s 
        self.symbol
    end

    def [](pos)
        row, col = pos
        board[row][col]
    end

    def []=(pos, value)
        row, col = pos
        board[row][col] = value
    end

    # checks if the pos is a NullPiece
    # returns true if NullPiece
    # returns false if another Piece subclass
    def empty?
       self[pos].is_a?(NullPiece)
    end
    
    # if in check, we remove all moves that don't remove check
    def valid_moves
        valid = []
        all_moves = self.moves

        all_moves.each do |end_pos|
            dup_board = board.dup

            dup_board.move_piece(pos, end_pos)

            valid << end_pos unless dup_board.in_check?(color)
        end
        
        valid
    end

    def valid_pos?(position)
        row, col = position

        return false if row < 0 || row > 7
        return false if col < 0 || row > 7

        true
    end

    def pos=(val)
        @pos = val
    end

    def symbol
        raise "should define in subclass"
    end

    # returns a dup of the current piece
    def dup
        self.class.new(color, board, pos)
    end

    private

    # if it's possible to check the other color, it prioritizes getting check
    def move_into_check?(end_pos)
        
    end
end