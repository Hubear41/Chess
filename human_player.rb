require_relative "player.rb"

class HumanPlayer << Player

    def make_move
        cursor = display.cursor
        done = false    # temp boolean
        
        until done
            begin
                system("clear")
                render(cursor.cursor_pos) # show board with cursor pos
                
                cursor.get_input

            # if invalid position, print message and don't update cursor pos
            rescue  
                puts "Not in range"
                sleep(1)
                
                retry
            end
        end
    end
end