require "set"

class GraphNode
    attr_accessor :value, :neighbors
    def initialize(value)
        @value = value
        @neighbors = []
    end
end

def bfs(starting_node, target_value, visited = Set.new())
    queue = [starting_node]
    searched_elements = [] #this allows you to keep track of what's been checked so far
    until queue.empty?
        el = queue.shift
        searched_elements << el.value
        visited.add(el.value) #this makes it the first one visited, so it doesn't tack it on to the end
        if el.value == target_value
            puts "The path towards #{el.value} was #{searched_elements}"
            return "found #{el.value}" #value for now just because it's simpler to read
        end
        el.neighbors.each do |child| #loop through all the children of the element in question
            unless visited.include?(child.value)
                queue << child
                visited.add(child.value)
            end
        end
    end
    puts "The path tried was #{searched_elements}"
    return "unable to find this element in the graph" #nothing was found
end

#example from the reading
a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a,b] #circles back, but that's handled by the "visited" set
f.neighbors = [e]

p bfs(a,'d') #woohoo! it works