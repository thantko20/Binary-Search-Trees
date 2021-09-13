require_relative 'node'
require 'pry-byebug'

# Tree class
# Initialized with array as argument
# must have root attr
# which a a return value of #build_tree method

# Init
class Tree
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
    return node.left = nil if check_left_node(value, node)

    node.right = nil if check_right_node(value, node)
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

  def check_left_node(value, node)
    return unless node.left && node.right && node.data == value

    check_leaf_node(value, node.left) ?  true : delete(value, node.left)
  end

  def check_right_node(value, node)
    check_leaf_node(value, node.right) ? true : delete(value, node.right)
  end

  def check_leaf_node(value, node)
    return true if !node.left && !node.right && node.data == value

    false
  end
end