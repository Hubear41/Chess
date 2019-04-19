require_relative "piece.rb"

module Stepable
    
    #calls move_diffs from either the King or Knight class
    def moves
        all_moves = []
        directions = move_diffs

        directions.each do |delta| # iterates through all piece directions
            row, col = pos
            dx, dy = delta 
            new_pos = [row + dx, col + dy]

            # checks if the new_pos is either empty, a teammate, or an enemy
            # only adds to all_moves if it's empty or an enemy
            unless valid_pos?(new_pos)
                all_moves << new_pos unless board[new_pos].color == self.color     
            end
        end

        all_moves
    end

end