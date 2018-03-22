require_relative "./node"
require "pry"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(score, name)
    node = Node.new(score, name)
    if @root == nil
      @root = node
    else
      place_node(node, @root)
    end #if root nil
    node.depth
  end #insert

  def place_node(new_node, top_node)
    return nil if new_node == nil
    new_node.depth += 1
    if new_node.score > top_node.score
      top_node.greater.nil? ? top_node.greater = new_node : place_node(new_node, top_node.greater)
    else
      top_node.lesser.nil? ? top_node.lesser = new_node : place_node(new_node, top_node.lesser)
    end #if new > top
  end #place_node

  def find_node(score, node = @root)
    result = nil
    if score == node.score
      result = node
    else
      if score > node.score
        result = node.greater.nil? ? nil : find_node(score, node.greater)
      else
        result = node.lesser.nil? ? nil : find_node(score, node.lesser)
      end #score > node
    end #if node = score
    result
  end #find node

  def include?(score)
    !find_node(score).nil?
  end #include

  def depth_of(score)
    node = find_node(score)
    node.nil? ? nil : node.depth
  end

  def max(node = @root)
    node.greater.nil? ? node : max(node.greater)
  end

  def min(node = @root)
    node.lesser.nil? ? node : min(node.lesser)
  end

  def sort(node = @root)
    node.to_a
  end

  def load(file_name)
     file = File.open(file_name, "r")
     movies = file.read.split("\n")
     movies_added = 0
     movies.each do |movie|
       movie_values = movie.split(",")
       score = movie_values[0].to_i
       name = movie_values[1].strip
       insert(score, name)
       movies_added += 1
     end #each movie
     movies_added
  end #load

  def all_nodes
    sort.map do |node_hash|
      node = find_node(node_hash.values[0])
    end
  end

  def health(depth)
    nodes = all_nodes.find_all { |node| node.depth == depth }

    nodes.map do |node|
      health_of_node(node)
    end
  end

  def health_of_node(node)
    #[score, number of kids, percent of whole]
    [node.score, sort(node).count, ((sort(node).count.to_f/sort(@root).count.to_f) * 100).to_i]
  end

  def leaves
    nodes = all_nodes.find_all { |node| node.greater == nil && node.lesser == nil }
    nodes.count
  end

  def height
    tree_height = 0
    all_nodes.each do |node|
      if node.depth > tree_height
        tree_height = node.depth
      end
    end
    # binding.pry
    tree_height + 1 # zero based depth
  end

  def delete(score)
    return nil if !include?(score)
    # promote lower max or greater min - the right way
    if @root.score == score
       delete_node(@root)
       return score
    else
      result = find_parent_of_node_to_delete(score)
      parent = result[0]
      is_lesser = result[1]
      # binding.pry
      if is_lesser
        delete_node(parent.lesser, parent, true)
      else
        delete_node(parent.greater, parent, true)
      end
    end
    # depth as calculated, not instance var?
    score
  end

  def find_parent_of_node_to_delete(score, node = @root)
    parent = nil
    if score < node.score
      if score == node.lesser.score  #can call for nil here
        parent = [node, true]
      else
        parent = find_parent_of_node_to_delete(score, node.lesser)
      end
    else # score is greater
      if score == node.greater.score #can call for nil here
        parent = [node, false]
      else
        parent = find_parent_of_node_to_delete(score, node.greater)
      end
    end
    parent #array - [parent, if delete lesser]
  end #find_parent

  def delete_node(node, parent = nil, is_lesser = false)
    # binding.pry
    if !parent.nil? #not the root
      is_lesser ? parent.lesser = nil : parent.greater = nil
      if !node.lesser.nil?
        place_node(node.lesser, @root)
      end
    else
      @root = node.lesser
    end
    place_node(node.greater, @root)
  end

end #bst class
#
# tree = BinarySearchTree.new
# tree.insert(61, "Bill & Ted's Excellent Adventure")
# tree.insert(75, "Hello World")
# tree.insert(98, "Animals United")
# tree.insert(58, "Armageddon")
# tree.insert(36, "Bill & Ted's Bogus Journey")
# tree.insert(93, "Bill & Ted's Excellent Adventure")
# tree.insert(86, "Charlie's Angels")
# tree.insert(38, "Charlie's Country")
# tree.insert(69, "Collateral Damage")
# # file = File.open("movies.txt", "r")
# tree.delete(69)
# # binding.pry #.split("\n"),
