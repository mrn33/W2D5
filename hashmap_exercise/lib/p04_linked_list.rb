class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.next.prev = self.prev
    self.prev.next = self.next
    self.next = nil
    self.prev = nil 
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    node = @head
    
    while node.next
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    node = @head
    
    while node.next
      return true if node.key == key
      node = node.next
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    
    node.prev = @tail.prev
    node.next = @tail
    
    node.prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    node = @head
    while node.next
      if node.key == key
        node.val = val
        return true
      end
      node = node.next
    end
    false
  end

  def remove(key)
    node = @head
    
    while node.next
      if node.key == key
        node.remove 
        return true
      end
      node = node.next
    end
    false
  end

  def each(&prc)
    node = @head.next
    
    while node.next
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
