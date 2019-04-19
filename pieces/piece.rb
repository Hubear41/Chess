class Piece
    attr_reader :pos, :color
    attr_accessor :board

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

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

    def empty?
       self[pos].is_a?(NullPiece)
    end
    
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
        return
    end

    def dup
        self.class.new(color, board, pos)
    end

    private

    def move_into_check?(end_pos)
        
    end
end