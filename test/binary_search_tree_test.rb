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
    # skip
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

  def test_it_can_check_health
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end #health

  def test_it_can_count_leaves
    assert_equal 2, @tree.leaves

    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal 2, tree.leaves

    tree.insert(99, "ger")
    tree.insert(33, "vvf")
    tree.insert(88, "vef")
    tree.insert(68, "v")

    assert_equal 5, tree.leaves
  end #leaves

  # height
  def test_it_can_check_height
    # What is the height (aka the maximum depth) of the tree?
    assert_equal 3, @tree.height

    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal 5, tree.height

    tree.insert(68, "ve")
    tree.insert(67, "t")
    tree.insert(23, "juy")

    assert_equal 7, tree.height

  end #height

  # Extension
  def test_delete_node_method
    @tree.delete_node(@tree.root.lesser, @tree.root, true)
    assert_equal 3, @tree.all_nodes.count
  end

  def test_it_can_delete_root
    @tree.delete(61)
    assert_equal 3, @tree.all_nodes.count
  end

  def test_it_can_delete_nodes
    # skip
    assert_equal 16, @tree.delete(16)
    assert_equal nil, @tree.delete(93)
    # binding.pry
    assert_equal 3, @tree.all_nodes.count
    @tree.insert(98, "Animals United")
    @tree.insert(58, "Armageddon")
    @tree.insert(93, "Bill & Ted's Excellent Adventure")
    # binding.pry
    assert_equal 93, @tree.delete(93)
    assert_equal nil, @tree.delete(22)
    assert_equal 5, @tree.all_nodes.count
  end

  #add tests for depth

end
