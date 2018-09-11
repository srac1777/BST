require 'bst_node'
require 'byebug'
class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_node(@root, value)
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if value == node.value

    if value <= node.value
      return find(value, node.left)
    else
      return find(value, node.right)
    end
  end


  def delete(value)
    @root = delete_node(@root, value)
  end


  def maximum(node = @root)
    current = node
    max = nil
    until current.right.nil?
      current = current.right
      max = current
    end
    max
  end

  def depth(node = @root)
    if node.nil?
      return -1;
    else
      left_depth = depth(node.left)
      right_depth = depth(node.right)
      if left_depth > right_depth
        return left_depth + 1
      else
        return right_depth + 1
      end
    end
  end

  def is_balanced?(node = @root)
    return true if node.nil?
     balanced = true
    left_depth = depth(node.left)
    right_depth = depth(node.right)
    balanced = false if (left_depth - right_depth).abs > 1
     if balanced && is_balanced?(node.left) && is_balanced?(node.right)
      return true
    end
    false
  end

  def in_order_traversal(node = @root, arr = [])
    if node.left
      in_order_traversal(node.left, arr)
    end

    arr.push(node.value)

    if node.right
      in_order_traversal(node.right, arr)
    end

    arr
  end

  private

  def insert_node(node, value)
    return BSTNode.new(value) if node.nil?

    if value <= node.value
      node.left = insert_node(node.left, value)
      # debugger
    elsif value > node.value
      node.right = insert_node(node.right, value)
    end
    node
  end

  def delete_node(node, value)
    if node.value == value
      node = remove(node)
    elsif value < node.value
      node.left = delete_node(node.left, value)
    else 
      node.right = delete_node(node.right, value)
    end
    node
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      node = nil
    elsif node.left.nil? && node.right
      node = node.right
    elsif node.right.nil? && node.left
      node = node.left
    else 
      # p node
      node = find_max_and_do_stuff(node)
    end
  end

  def find_max_and_do_stuff(node)

    parent = node.left
    current = parent.right
    max = current
    until parent.right.right.nil?
      parent = parent.right
      current = parent.right.right
      max = current
    end
    # debugger
    if max.left.nil?
      return max
    else
      # to_return = max
      # p max
      parent.right = max.left
      # p max
      max.left = node.left
      max.right = node.right
      return max
    end 
  end
end


# def remove(node)
  
# end


# def promote_child(node)
  
# end