
class HashSet
  attr_accessor :count, :num_buckets
  def initialize(num_buckets = 8)
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
    store[num.hash % num_buckets]
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
