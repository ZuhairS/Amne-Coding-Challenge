# Input
# 5 3
# 188930 194123 201345 154243 154243

# Output
# 3
# 0
# -1

class SalesPattern

  def initialize(input_file = "input.txt")
    input_arr = File.readlines(input_file).map(&:strip)
    @num_of_days, @window_size = input_arr.first.split(" ").map(&:to_i)
    @sale_prices = input_arr.last.split(" ").map(&:to_i)
    find_pattern
  end

  def find_pattern
    result = []
    @sale_prices[0..-@window_size].each_index do |idx|
      increasing_count = count_increasing_range(@sale_prices[idx...idx + @window_size])
      decreasing_count = count_decreasing_range(@sale_prices[idx...idx + @window_size])
      result << increasing_count - decreasing_count
    end

    print_output(result)
  end

  private

  def count_increasing_range(prices)
    return 0 if prices.length < 2
    cache = Array.new(@window_size, 0)

    prices.each_with_index do |price, idx|
      next if idx == 0
      cache[idx] += 1 if price > prices[idx - 1]
    end

    (1...prices.length).each do |curr_idx|
      (0...curr_idx).each do |test_idx|
        cache[curr_idx] += cache[test_idx] if prices[curr_idx] > prices[test_idx]
      end
    end

    cache.reduce(:+)
  end

  def count_decreasing_range(prices)
    return 0 if prices.length < 2
    cache = Array.new(@window_size, 0)

    prices.each_with_index do |price, idx|
      next if idx == 0
      cache[idx] += 1 if price < prices[idx - 1]
    end

    (1...prices.length).each do |curr_idx|
      (0...curr_idx).each do |test_idx|
        cache[curr_idx] += cache[test_idx] if prices[curr_idx] < prices[test_idx]
      end
    end

    cache.reduce(:+)
  end

  def print_output(result)
    File.write('output.txt', result.join("\n"))
  end

end

pattern = SalesPattern.new
