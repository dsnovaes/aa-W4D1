require "byebug"

class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @children = []
        @parent = nil
    end

    def parent=(parent)
        if self.parent != nil
            old_parent = self.parent.children

            # if the node is already child of other node
            idx = 0
                old_parent.each_with_index do |ele,i|
                    if ele == self
                        idx = i
                        break
                    end
                end
                old_parent.delete_at(idx)
            end

        @parent = parent # assigning a parent to the node

        if self.parent != nil && !parent.children.include?(self)
            parent.children << self
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if children.include?(child_node)
            child_node.parent = nil
        else
            raise "not a child"
        end
    end


    def dfs(target_value) #recursive
        return self if self.value == target_value
        self.children.each do |child|
            search_result = child.dfs(target_value) #need to make it child. so it doens't accept two arguments
            return search_result unless search_result.nil?
        end
        return nil
    end

    def bfs(target_value) #iterative
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value == target_value
            el.children.each do |child|
                queue << child
            end
        end
        return nil
    end

    

end

# root = PolyTreeNode.new("a")
# child_b = PolyTreeNode.new("b")
# child_c = PolyTreeNode.new("c")
# child_d = PolyTreeNode.new("d")
# child_e = PolyTreeNode.new("e")
# child_b.parent = root
# child_c.parent = root
# child_d.parent = child_b
# child_e.parent = child_c
# p root.bfs("c")

# p child
# puts
# p root
