require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :num_buckets, :store

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key,val)
    else
       if self.count+1 >= num_buckets
        resize!
      end
      bucket(key).append(key,val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      self.count -= 1
    end
  end

  def each 
    store.each do |list|
      list.each {|node| yield [node.key,node.val]}
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets*2){LinkedList.new}
    store.each do |list|
      list.each do |node|
        temp[node.key.hash % (num_buckets*2)].append(node.key,node.val)
      end

    end
    self.num_buckets = num_buckets*2
    self.store = temp
  end

  def bucket(key)
    store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end

