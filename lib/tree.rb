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

  # This method will build a tree with elements from arr
  # Lets imagine a tree for an array [1,2,3,4,5]
  # We will recursively set the mid of the array as root
  # Then do the same for the left half of the array
  # ........ right half of the array
  # return stack if !arr
  #return roots for every level
  def build_tree(arr)
    # I need base case
    # Gotta return if it is not arr(or empty)
    #binding.pry
    return nil if arr.empty?
    # set mid point
    mid = arr.size/2
    node = Node.new(arr[mid])
    node.left = build_tree(arr.slice(0, mid))
    node.right = build_tree(arr.slice(mid+1, arr.size))

    return node
  end
end