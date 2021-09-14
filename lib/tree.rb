require_relative 'comparable'
require_relative 'node'
require 'pry-byebug'

# Tree class
# Initialized with array as argument
# must have root attr
# which a a return value of #build_tree method

# Init
class Tree
  include Comparable

  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr)
    return if arr.empty?

    mid = arr.size/2
    node = Node.new(arr[mid])
    node.left = build_tree(arr.slice(0, mid))
    node.right = build_tree(arr.slice(mid+1, arr.size))

    node
  end

  def insert(value, node=@root)
    return if node.data == value

    value > node.data ? insert_right(value, node) : insert_left(value, node)
  end

  def delete(value, node=@root)
    return node if node.nil?

    if node.data > value
      node.left = delete(value, node.left)
    elsif node.data < value
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      delete_node_with_two_child(node)
    end
    node
  end

  def level_order
    return if @root.nil?

    arr = []
    arr.push(@root)
    queue(arr)
  end

  def find(value, node=@root)
    return if node.nil?

    return node if node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def preorder(node=@root, arr=[])
    return if node.nil?

    arr.push(node.data)
    preorder(node.left, arr)
    preorder(node.right, arr)
    arr
  end

  def inorder(node=@root, arr=[])
    return if node.nil?

    inorder(node.left, arr)
    arr.push(node.data)
    inorder(node.right, arr)
    arr
  end

  def postorder(node=@root, arr=[])
    return if node.nil?

    postorder(node.left, arr)
    postorder(node.right, arr)
    arr.push(node.data)
    arr
  end

  def height(node=@root)
    return -1 if node.nil?

    left = height(node.left)
    right = height(node.right)

    max_height(left, right) + 1
  end

  def depth(node, curr_node=@root)
    return 0 if curr_node == node

    if curr_node.data > node.data
      node_depth = depth(node, curr_node.left)
    elsif curr_node.data < node.data
      node_depth = depth(node, curr_node.right)
    end
    node_depth + 1
  end

  def balance?(node=@root)
    return if node.nil?

    left = height(node.left)
    right = height(node.right)

    diff = (left - right).abs
    diff <= 1
  end

  def rebalance
    arr = inorder
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def insert_left(value, node)
    node.left ? insert(value, node.left) : node.left = Node.new(value)
  end

  def insert_right(value, node)
    node.right ? insert(value, node.right) : node.right = Node.new(value)
  end

  def delete_node_with_two_child(node)
    tmp = min_node(node.right)
    node.data = tmp.data
    node.right = delete(tmp.data, node.right)
  end

  def min_node(node)
    tmp = node
    tmp = tmp.left until tmp.left.nil?
    tmp
  end

  def queue(arr)
    arr_of_values = []
    until arr.empty?
      curr_node = arr.first
      arr_of_values.push(curr_node.data)
      arr.push(curr_node.left) if curr_node.left
      arr.push(curr_node.right) if curr_node.right
      arr.shift
    end
    arr_of_values
  end

  def max_height(left, right)
    left < right ? right : left
  end
end
