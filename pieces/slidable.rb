require_relative "piece.rb"

module Slidable
    HORIZONTAL_DIRS = [
        [0,1],
        [0,-1],
        [1,0],
        [-1,0]
    ]
    DIAGONAL_DIRS = [
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]
    ]

 
    # finds all horiontal moves that are unblocked using HORIZONTAL_DIRS
    def horizontal_dirs
        horizontal = [[]]

        HORIZONTAL_DIRS.each do |delta|
            dx, dy = delta
            horizontal += grow_unblocked_moves_in_dir(dx, dy)
        end

        horizontal
    end

    # finds all possible diaganol moves that are unblocked us DIAGANOL_DIRS
    def diagonal_dirs
        diagonal = [[]]

        DIAGONAL_DIRS.each do |delta|
            dx, dy = delta
            diagonal += grow_unblocked_moves_in_dir(dx, dy)
        end

        diagonal
    end

    # Decids all moves based on what directions are valid
    def moves
        dir = move_dirs
        all_moves = []

        case dir
        when :horizontal
            all_moves += horizontal_dirs
        when :diagonal
            all_moves += diagonal_dirs
        when :both
            all_moves += horizontal_dirs + diagonal_dirs
        end

        all_moves
    end

    private 
    def move_dirs
        #Cannot call move_dirs in module. Will need to implement in sub-classes

        raise "Implement move_dirs in sub-classes"
    end

    # finds all possible moves in the [dx, dy] directon until it is blocked
    # it is blocked when out of bounds, are on a piece of the same team, 
    # or after attacking an enemy piece
    def grow_unblocked_moves_in_dir(dx, dy)
        row, col = pos
        blocked = false
        unblocked_pieces = []

        step_num = 1 # used to increase the delta by one step each round

        # iterates through all moves by increasing the step_num each round
        # once blocked is true, the loop ends
        until blocked
            new_row = row + dx * step_num
            new_col = col + dy * step_num
            new_pos = [new_row, new_col]
            
            return unblocked_pieces if valid_pos?(new_pos)
           
            # if the new_pos is one the same team, we are immediately blocked.
            # if the new_pos is of the other team, we can 
            # add the pos and then set blocked equal to true afterwards
            unless board[new_pos].color == self.color     
                unblocked_pieces << new_pos
            else
                blocked = true
            end
            
            # keep iterating if the new_pos is an empty position
            blocked = true unless board[new_pos].empty?

            step_num += 1
        end

        unblocked_pieces
    end
end