require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < MiniTest::Test

# Base Expectations
# Build a binary search tree which can fulfill each of the interactions below.
# Assume we’ve started with:
def setup
  @tree = BinarySearchTree.new

  @tree.insert(61, "Bill & Ted's Excellent Adventure")
  @tree.insert(16, "Johnny English")
  @tree.insert(92, "Sharknado 3")
  @tree.insert(50, "Hannibal Buress: Animal Furnace")
end

def test_it_exists
  assert_instance_of BinarySearchTree, @tree
end

def test_it_can_insert
  new_tree = BinarySearchTree.new
  depth = new_tree.insert(61, "Bill & Ted's Excellent Adventure")
  assert_equal 0, depth
  depth = new_tree.insert(16, "Johnny English")
  assert_equal 1, depth
  depth = new_tree.insert(92, "Sharknado 3")
  assert_equal 1, depth
  depth = new_tree.insert(50, "Hannibal Buress: Animal Furnace")
  assert_equal 2, depth
  depth = new_tree.insert(50, "I'm a duplicate score")
  assert_equal 3, depth
  depth = new_tree.insert(90, "I'm a lower depth")
  assert_equal 2, depth
end

def test_it_can_include
  assert @tree.include?(16)
  refute @tree.include?(72)
  assert @tree.include?(92)
  refute @tree.include?(21)
end

def test_it_can_return_depth
  assert_equal 1, @tree.depth_of(92)
  assert_equal 2, @tree.depth_of(50)
end

def test_it_can_return_max
  max = @tree.max
  assert_equal max.name, "Sharknado 3"
  assert_equal max.score, 92
end

def test_it_can_return_min
  min = @tree.min
  assert_equal min.name, "Johnny English"
  assert_equal min.score, 16
end

def test_it_can_sort
  # Return an array of all the movies and scores in sorted ascending order. Return them as an array of hashes. Note: you’re not using Ruby’s Array#sort. You’re traversing the tree.
  assert_equal @tree.sort, [{"Johnny English"=>16}, {"Hannibal Buress: Animal Furnace"=>50}, {"Bill & Ted's Excellent Adventure"=>61}, {"Sharknado 3"=>92}]
  # add extra: (new duplicates sorted to left)
  @tree.insert(50, "duplicate score")
  @tree.insert(90, "I'm new")
  @tree.insert(61, "root duplicate")
  @tree.insert(99, "high score")
  @tree.insert(1, "low score")

  assert_equal @tree.sort, [{"low score"=>1}, {"Johnny English"=>16}, {"duplicate score"=>50}, {"Hannibal Buress: Animal Furnace"=>50}, {"root duplicate"=>61}, {"Bill & Ted's Excellent Adventure"=>61}, {"I'm new"=>90}, {"Sharknado 3"=>92}, {"high score"=>99}]
end

def test_it_can_load
  # Assuming we have a file named movies.txt with one score/movie pair per line:
  assert_equal 99, @tree.load('movies.txt')
  assert_equal 103, @tree.sort.count
  assert @tree.include?(58)
  assert_equal "Cruel Intentions", @tree.min.name
end

# health
def test_it_can_check_health
  # Report on the health of the tree by summarizing the number of child nodes (nodes beneath each node) at a given depth. For health, we’re worried about 3 values:
  #
  # Score of the node
  # Total number of child nodes including the current node
  # Percentage of all the nodes that are this node or it’s children
  tree = BinarySearchTree.new
  tree.insert(98, "Animals United")
  tree.insert(58, "Armageddon")
  tree.insert(36, "Bill & Ted's Bogus Journey")
  tree.insert(93, "Bill & Ted's Excellent Adventure")
  tree.insert(86, "Charlie's Angels")
  tree.insert(38, "Charlie's Country")
  tree.insert(69, "Collateral Damage")
  assert_equal [[98, 7, 100]], tree.health(0)
  # => [[98, 7, 100]]
  assert_equal [[58, 6, 85]], tree.health(1)
  # => [[58, 6, 85]]
  assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  # => [[36, 2, 28], [93, 3, 42]]
  # Where the return value is an Array with one nested array per node at that level. The nested array is:
  #
  # [score in the node, 1 + number of child nodes, floored percentage of (1+children) over the total number of nodes]
  # When the percentages of two nodes at the same level are dramatically different, like 28 and 42 above, then we know that this tree is starting to become unbalanced.
end
#
# Understanding the Shape
# This extensions is made up of two methods:
#
# leaves
def test_it_can_count_leaves
# A leaf is a node that has no left or right value. How many leaf nodes are on the tree?
#
# tree.leaves
# # => 2
end

# height
def test_it_can_check_height
# What is the height (aka the maximum depth) of the tree?
#
# tree.height
# # => 3
end

# Extension
# Deleting Nodes
def test_it_can_delete_nodes
# Remove a specified piece score from the tree:
#
# tree.delete(30)
# # => 30
# tree.delete(101)
# # => nil
# Note that any children of the deleted node should still be present in the tree.
end
#
# Evaluation Rubric
# The project will be assessed with the following guidelines:
#
# 4: Above expectations
# 3: Meets expectations
# 2: Below expectations
# 1: Well-below expectations
# Expectations:
#
# 1. Ruby Syntax & Style
# Applies appropriate attribute encapsulation
# Developer creates instance and local variables appropriately
# Naming follows convention (is idiomatic)
# Ruby methods used are logical and readable
# Code is indented properly
# Code does not exceed 80 characters per line
# Each class has correctly-named files and corresponding test files in the proper directories
# 2. Breaking Logic into Components
# Code is effectively broken into methods & classes
# Developer writes methods less than 10 lines
# No more than 3 methods break the principle of SRP
# 3. Test-Driven Development
# Each method is tested
# Tests implement Ruby syntax & style
# Tests exist to cover edge cases
# Tests covers critical functionality of software
# Testing exhibits TDD approach
# Test coverage is measured with SimpleCov
# Test coverage exceeds 95%
# 4. Version Control
# Expectations:
#
# Developer commits at a pace of at least 1 commit per hour
# Developer implements branching and PRs
# The final submitted version is merged into master
# 5. Functionality
# Application meets all requirements (extension not req’d)
end
