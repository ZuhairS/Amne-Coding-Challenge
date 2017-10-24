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
    count = 0
    prices.each_with_index do |price, idx|
      next if idx == 0
      count += 1 if price > prices[idx - 1]
    end

    count += count_increasing_range(prices[1..-1])
    p count
    count
  end

  def count_decreasing_range(prices)
    2
  end

  def print_output(result)
    File.write('output.txt', result.join("\n"))
  end

end

pattern = SalesPattern.new
