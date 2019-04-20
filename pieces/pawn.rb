require_relative "piece.rb"
require "byebug"
class Pawn < Piece
    def symbol
         "\u265F".encode('utf-8')
    end

    # inclues all steps and attacks
    def moves
        forward_steps + side_attacks
    end

    # if it's at it's starting row, we give it an extra step of 2 
    def at_start_rows?
        row = pos[0]
        
        return true if row == 1 || row == 6
            
        false
    end

    private
    
    # determines which direction it moves based on team color
    # goes down if it's a black pawn, and up if it's a white pawn
    def forward_dir
        if @color == :black
            1
        else
            -1
        end
    end

    # check if it can move 1 or 2 steps forward
    def forward_steps
        forward = forward_dir
        steps = []
        row, col = pos

        step1 = [row + forward, col]

        unless valid_pos?(step1)
            steps << step1

            if at_start_rows?
                step2 = [row + forward * 2, col]
                
                steps << step2 if valid_pos?(step2)
            end
        end

        steps
    end

    # checks if an enemy is in it's 2 attack positions and returns those moves
    def side_attacks
        forward = forward_dir
        row, col = pos
        attacks = []

        next_row = row + forward # sets next_row to the following row
        unless next_row > 7 || next_row < 0
            left_col = col - 1
            right_col = col + 1

            left_attack = [next_row, left_col]
            right_attack = [next_row, right_col]
            
            attacks << right_attack if valid_pos?(right_attack) && board[right_attack].color != self.color
            attacks << left_attack if valid_pos?(left_attack) && board[left_attack].color != self.color
        end

        attacks
    end

    
end