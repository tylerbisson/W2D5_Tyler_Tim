require 'byebug'
class MaxIntSet
  
  def initialize(max)
    @max = max 
    @store = Array.new(max + 1){false}
    @size = max + 1
  end

  def insert(num)
    store[num] = true if is_valid?(num)
  end

  def remove(num)
    store[num] = false if is_valid?(num)
  end

  def include?(num)
    store[num]
  end

  private
  attr_accessor :max, :size, :store

  def is_valid?(num)
    return true if num >= 0 && num <= max
    validate!(num)
  end

  def validate!(num)
    raise "Out of bounds"
  end
end


class ResizingIntSet
  attr_accessor :count, :num_buckets
  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0 
  end

  def insert(num)
    unless include?(num)
      if self.count+1 >= num_buckets
        resize!
      end
      self[num] << num
      self.count +=1
    end
  end
  

  def remove(num)
    if self.include?(num)
      self[num].delete(num) 
      self.count -=1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_accessor :store
  def [](num)
    # optional but useful; return the  bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
  
  def resize!
    temp = Array.new(store.length*2){Array.new}
    store.each do |arr|
      arr.each do |num|
        temp[num % (store.length*2)] << num
      end
    end
    self.num_buckets = store.length*2
    self.store = temp
  end
end

class IntSet
  attr_accessor :count, :num_buckets

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
  
    unless self.include?(num)
      
      self[num] << num
      self.count +=1
      
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num) 
      self.count -=1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  
end

