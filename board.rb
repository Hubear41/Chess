require_relative "piece.rb"
require_relative "display.rb"
require_relative "cursor.rb"

class Board
    def initialize 
        @board = Array.new(8){Array.new(8)}

        fill_rows_and_pawns # fills pawn location and nullpieces
        add_pieces  # adds everything else
    end

    # will move piece at start_pos to end_pos if end_pos is empty
    # will raise error if start_pos is not a playable piece
    # will check if the end_pos is in it's valid position or if it would put the player in check
    def move_piece(start_pos, end_pos)
        curr_piece = self[start_pos]

        raise "There is no piece at the first position" if curr_piece.is_a? NullPiece
        
        valid_moves = curr_piece.valid_moves

        if valid_moves.include(end_pos)
            move_piece!(start_pos, end_pos)
        elsif curr_piece.move_into_check?(end_pos)
            raise "This move will cause you to be in check"
        else
            raise "can't move the piece to that position"
        end
    end 

    def move_piece!(start_pos, end_pos)
        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    end

    def [](position)
        row, col = position
        @board[row][col]
    end

    def []=(position, piece)
        row, col = position

        @board[row][col] = piece
    end

    def valid_pos?(pos)
        row, col = pos
        return false if row < 0 || row > 7
        return false if col < 0 || col > 7
        true
    end

    # looks through the whole board for the pos of the matching color's King
    def find_king(color)
        board.each do |row|
            (0...row.length).each do |col|
                pos = [row,col]
                king_pos = pos if board[pos].symbol == :King && board[pos].color == color
            end
        end
        king_pos
    end

    # Look for a piece that has the King's position in it's moves
    # Returns true if found, otherwise false
    def in_check?(color)
        king_pos = find_king(color)
       
        board.each do |row|
            (0...row.length).each do |col|
                pos = [row,col]
                if board[pos].color != color
                    enemy_piece = board[pos]
                    return true if enemy_piece.moves.include?(king_pos)
                end
            end
        end

        false
    end

    # calls in_check? for opposite color and checks if all possible moves for
    # the king piece
    # returns true if there are are no moves possible for king piece
    # return false if there is at least one move for the king piece 
    def checkmate?(color)
        if in_check?(color)

            board.each do |row|
                (0...row.length).each do |col|
                    pos = [row,col]

                    if board[pos].color == color
                        our_piece = board[pos]
                        return true unless our_piece.moves.empty?
                    end
                end
            end
        end

        false
    end


    # creates a dup for the board all a dup for all pieces
    def dup
        dup_board = Board.new 
        @board.each do |row|
            (0...row.length).each do |col|
                pos = [row,col]
                dup_board[pos] = @board[pos].dup
            end
        end    
        
        dup_board
    end

    private

    # adds pawn and nullpieces into the starting position
    def fill_rows_and_pawns
        (1..6).each do |row|
            (0..7).each do |col|
                if row == 1  
                    @board[row][col] = Pawn.new(:black, self, [row, col])
                elsif row == 6
                   @board[row][col] = Pawn.new(:white, self,  [row, col])
                else
                    @board[row][col] = NullPiece.instance
                end
            end
        end
    end

    # adds all piece objects except pawn and nullpiece
    def add_pieces
        (0..7).each do |col|
            case col
            when 0, 7
                @board[0][col] = Rook.new(:black, self, [0, col])
                @board[7][col] = Rook.new(:white, self,  [7, col])
            when 1, 6
                @board[0][col] = Knight.new(:black, self, [0, col])
                @board[7][col] = Knight.new(:white, self,  [7, col])
            when 2, 5
                @board[0][col] = Bishop.new(:black, self, [0, col])
                @board[7][col] = Bishop.new(:white, self,  [7, col])
            when 3
                @board[0][col] = Queen.new(:black, self, [0, col])
                @board[7][col] = Queen.new(:white, self,  [7, col])
            when 4
                @board[0][col] = King.new(:black, self, [0, col])
                @board[7][col] = King.new(:white, self,  [7, col])
            end
        end
    end
end