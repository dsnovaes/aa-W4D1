require_relative "poly_tree_node"

class KnightPathFinder
    attr_accessor :position, :considered_positions, :root_node

    def self.valid_moves(pos)
        moves = []
        x,y = pos
        # pos_1 = [x+1,y+2]
        # pos_2 = [x+2,y+1]
        # pos_3 = [x+1,y-2]
        # pos_4 = [x+2,y-1]
        # pos_5 = [x-1,y+2]
        # pos_6 = [x-2,y+1]
        # pos_7 = [x-1,y-2]
        # pos_8 = [x-2,y-1]

        if x + 1 >= 0 && x + 1 < 8 && y + 2 >= 0 && y + 2 < 8
            moves << [x+1,y+2]
        end
        if x + 2 >= 0 && x + 2 < 8 && y + 1 >= 0 && y + 1 < 8
            moves << [x+2,y+1]
        end
        if x + 1 >= 0 && x + 1 < 8 && y - 2 >= 0 && y - 2 < 8
            moves << [x+1,y-2]
        end
        if x + 2 >= 0 && x + 2 < 8 && y - 1 >= 0 && y - 1 < 8
            moves << [x+2,y-1]
        end
        if x - 1 >= 0 && x - 1 < 8 && y + 2 >= 0 && y + 2 < 8
            moves << [x-1,y+2]
        end
        if x - 2 >= 0 && x - 2 < 8 && y + 1 >= 0 && y + 1 < 8
            moves << [x-2,y+1]
        end
        if x - 1 >= 0 && x - 1 < 8 && y - 2 >= 0 && y - 2 < 8
            moves << [x-1,y-2]
        end
        if x - 2 >= 0 && x - 2 < 8 && y - 1 >= 0 && y - 1 < 8
            moves << [x-2,y-1]
        end

        moves
    end

    

    def initialize(initial_position)
        @position = initial_position
        @root_node = PolyTreeNode.new(initial_position)
        @considered_positions = [initial_position]
        build_move_tree
    end

    def find_path(target_position)
        target_node = root_node.bfs(target_position) #this saves the return of BFS as the target node
        trace_path_back(target_node) #and then we go back!!!!!
    end

    def trace_path_back(target_node)
        path = []
        temp_node = target_node
        # go up and up every parent, until parent == root_node
        until path.include?(root_node.value)
            path << temp_node.value
            temp_node = temp_node.parent
        end
        return path.reverse

    end

    def build_move_tree
        # use @root_node to start building the move tree
        queue = [root_node]
        until queue.empty?
            el = queue.shift
            new_moves = new_move_positions(el.value)
            new_moves.each do |position|
                new_position = PolyTreeNode.new(position)
                queue << new_position
                # @@nodes[position] = new_position
                new_position.parent = el
            end
            # puts el.parent
        end
        # return queue
    end

    def new_move_positions(pos)
        possible_moves = KnightPathFinder.valid_moves(pos)
        temp_moves = []
        possible_moves.each do |move|
            temp_moves << move unless @considered_positions.include?(move)
        end
        @considered_positions += temp_moves 
        return temp_moves

    end
end

knight = KnightPathFinder.new([1,1])
p knight.find_path([5,4])
# p knight.trace_path_back([5,4])
# p knight
# p KnightPathFinder.valid_moves([1,1])
# p knight.new_move_positions([1,1])
# puts
# p knight.build_move_tree
# p knight.find_path([4,4])