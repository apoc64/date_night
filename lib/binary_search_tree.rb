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
    new_node.depth += 1
    if new_node.score > top_node.score
      top_node.greater.nil? ? top_node.greater = new_node : place_node(new_node, top_node.greater)
      # if top_node.greater.nil?
      #   top_node.greater = new_node
      # else
      #   place_node(new_node, top_node.greater)
      # end # if top nil
    else
      top_node.lesser.nil? ? top_node.lesser = new_node : place_node(new_node, top_node.lesser)
      # if top_node.lesser.nil?
      #   top_node.lesser = new_node
      # else
      #   place_node(new_node, top_node.lesser)
      # end #if top nil
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

  def health(depth)
    # left.sort.count/right.sort.count ...
  end

  def leaves
  end

  def height
  end 

  def delete
    # re - insert both children
    # depth as calculated, not instance var?
  end

end #bst class

# tree = BinarySearchTree.new
# tree.insert(61, "Bill & Ted's Excellent Adventure")
# tree.insert(75, "Hello World")
# file = File.open("movies.txt", "r")
# binding.pry #.split("\n"),
