class Stack
  include Enumerable
  def initialize(value = nil)
    @stack = []
    if value.nil?
      return
    elsif value.is_a?(Array)
      value.each do |el|
        push(el)
      end
    else
      push(value)
    end
  end

  def self.new_with_metadata(metadata_name, &prc)
    stack = self.new
    stack.instance_variable_set(:@metadata, {max: "#{metadata_name}_max", min: "#{metadata_name}_min", proc: prc})

    define_method("#{metadata_name}_max"){
      raise "such metadata has not been set for this instance" if @metadata.nil?
      return nil if @stack.empty?
      @stack.last[@metadata[:max]]
    }
    define_method("#{metadata_name}_min"){
      raise "such metadata has not been set for this instance" if @metadata.nil?
      return nil if @stack.empty?
      @stack.last[@metadata[:min]]
    }
    stack
  end

  def peek
    return nil if @stack.empty?
    @stack.last[:value]
  end

  def min
    return nil if @stack.empty?
    @stack.last[:min]
  end

  def max
    return nil if @stack.empty?
    @stack.last[:max]
  end

  def length
    @stack.length
  end

  def empty?
    @stack.length == 0
  end

  def push(value)
    stack_el = {value: value}
    if @stack.empty?
      stack_el[:max] = stack_el[:min] = stack_el[:value]
      unless @metadata.nil?
        stack_el[@metadata[:max]] = stack_el[@metadata[:min]] = stack_el[:value]
      end
    else
      stack_el[:max] = stack_el[:value] >= max ? stack_el[:value] : max
      stack_el[:min] = stack_el[:value] <= min ? stack_el[:value] : min
      if @metadata
        proc = @metadata[:proc]

        if proc.call(stack_el[:value]) >= proc.call(self.send("#{@metadata[:max]}"))
          stack_el[@metadata[:max]] = stack_el[:value]
        else
          stack_el[@metadata[:max]] = self.send("#{@metadata[:max]}")
        end

        if proc.call(stack_el[:value]) <= proc.call(self.send("#{@metadata[:min]}"))
          stack_el[@metadata[:min]] = stack_el[:value]
        else
          stack_el[@metadata[:min]] = self.send("#{@metadata[:min]}")
        end
      end
    end
    @stack << stack_el
    self
  end

  def pop
    return nil if @stack.empty?
    top_el = @stack.pop
    top_el[:value]
  end

  def each(&prc)
    @stack.each do |el|
      prc.call(el[:value])
    end
  end

  def each_from_top(&prc)
    (@stack.length - 1).downto(0) do |i|
      prc.call(@stack[i][:value])
    end
    self
  end

end
