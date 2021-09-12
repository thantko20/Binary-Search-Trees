# Tree class
# Initialized with array as argument
# must have root attr
# which a a return value of #build_tree method

# Init
class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = #build_tree
  end

  # This method will build a tree with elements from arr
  # Lets imagine a tree for an array [1,2,3,4,5]
  # We will recursively set the mid of the array as root
  # Then do the same for the left half of the array
  # ........ right half of the array
  # return stack if !arr
  #return roots for every level
  
end