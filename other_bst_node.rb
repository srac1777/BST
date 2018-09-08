class BSTNode
  attr_accessor :value, :left, :right, :parent

  def initialize(value, parent = nil)
    self.value = value
    self.parent = parent
    self.left = nil
    self.right = nil
  end
end


def bst(arr)
  return nil if arr.length == 0
  return BSTNode.new(arr[0]) if arr.length == 1
  median_idx = (arr.length) / 2
  median = BSTNode.new(arr[median_idx])
  median.left = bst(arr[0...median_idx])
  median.right = bst(arr[median_idx+1..-1])
  return median
end

p bst([1,2,3,4,5,6,7])
