class CircularQueue

  def initialize(spots)
    @queue = Array.new(spots)
    @all_elements = []
  end

  def dequeue
    replace(@all_elements.shift)
  end

  def enqueue(object)
    @all_elements << object
    # if @queue.all? == nil
    #   @queue[0] = object
    # elsif @queue.first == nil
    #   @queue.shift
    #   @queue << object
    # else

    # end
    if @queue.include?(nil)
      replace(nil, object)
    else
      replace(@all_elements.shift, object)
    end
  end

  def to_s
    "#{@queue} is the queue."
  end

  private

  def replace(object, new_ob=nil)
    if @queue.include?(object)
      index = @queue.index(object)
      item = @queue.slice!(index)
      @queue.insert(index, new_ob)
    end
    item
  end
end

queue = CircularQueue.new(3)
# puts queue.dequeue == nil

queue.enqueue(1)
puts queue
queue.enqueue(2)
puts queue
queue.dequeue #== 1
puts queue

queue.enqueue(3)
puts queue
queue.enqueue(4)
puts queue
queue.dequeue #== 2
puts queue

# queue.enqueue(5)  # replaces existing objects
# puts queue
# queue.enqueue(6)
# puts queue
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue
# puts queue.dequeue == 6
# puts queue
# puts queue.dequeue == 7
# puts queue
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil
# # The above code should display true 15 times.