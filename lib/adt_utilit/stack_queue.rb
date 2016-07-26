require_relative "queue"
require_relative "stack"
class StackQueue
  include Enumerable
  def initialize(value = nil)
    @stack_a = Stack.new
    @stack_b = Stack.new
    if !value.nil?
      if value.is_a?(Array)
        value.each { |el| @stack_a.push(el) }
      else
        @stack_a.push(value)
      end
    end
  end

  def peek
    slinky if @stack_b.empty?
    @stack_b.peek
  end

  def last
    if @stack_a.empty?
      @stack_b_bottom
    else
      @stack_a.peek
    end
  end

  def enqueue(value)
    @stack_a.push(value)
  end

  def dequeue
    return nil if self.empty?
    slinky if @stack_b.empty?
    @stack_b.pop
  end

  def min
    return nil if self.empty?
    return @stack_a.min if @stack_b.min.nil?
    return @stack_b.min if @stack_a.min.nil?
    [@stack_a.min, @stack_b.min].min
  end

  def max
    return nil if self.empty?
    return @stack_a.max if @stack_b.max.nil?
    return @stack_b.max if @stack_a.max.nil?
    [@stack_a.max, @stack_b.max].max
  end

  def length
    @stack_a.length + @stack_b.length
  end

  def empty?
    @stack_a.empty? && @stack_b.empty?
  end

  def self.new_with_metadata(metadata_name, &prc)
    stack_queue = self.new
    stack_queue.instance_variable_set(:@metadata, {
      max: "#{metadata_name}_max",
      min: "#{metadata_name}_min",
      proc: prc
    })
    stack_queue.instance_variable_set(:@stack_a, Stack.new_with_metadata(metadata_name, &prc))
    stack_queue.instance_variable_set(:@stack_b, Stack.new_with_metadata(metadata_name, &prc))

    define_method("#{metadata_name}_max") {
      raise "such metadata has not been set for this instance" if @metadata.nil?
      return nil if self.empty?
      prc = @metadata[:proc]
      stack_a_max = @stack_a.send(@metadata[:max])
      stack_b_max = @stack_b.send(@metadata[:max])

      return stack_b_max if stack_a_max.nil?
      return stack_a_max if stack_b_max.nil?
      if prc.call(stack_a_max) < prc.call(stack_b_max)
        return stack_b_max
      else
        return stack_a_max
      end
    }

    define_method("#{metadata_name}_min"){
      raise "such metadata has not been set for this instance" if @metadata.nil?
      return nil if self.empty?
      prc = @metadata[:proc]
      stack_a_min = @stack_a.send(@metadata[:min])
      stack_b_min = @stack_b.send(@metadata[:min])

      return stack_b_min if stack_a_min.nil?
      return stack_a_min if stack_b_min.nil?
      if prc.call(stack_a_min) < prc.call(stack_b_min)
        return stack_b_min
      else
        return stack_a_min
      end
    }

    return stack_queue
  end

  def each(&prc)
    @stack_b.each_from_top(&prc)
    @stack_a.each(&prc)
    self
  end

  private
  def slinky
    if @stack_b.empty?
      @stack_b_bottom = @stack_a.peek
      @stack_b.push(@stack_a.pop) until @stack_a.empty?
    end
  end

end
