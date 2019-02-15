class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next 
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    self.each {|node| return node.val if node.key == key}
  end

  def include?(key)
    self.each {|node| return true if node.key == key}
    false 
  end

  def append(key, val)
    node = Node.new(key,val)
    node.next = tail
    node.prev = self.last
    node.prev.next = node
    node.next.prev = node
  end

  def update(key, val)
    self.each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
      end
    end
  end

  def each
    node = self.first
    until node == self.tail
      yield node
      node = node.next
    end
    
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
  
end
