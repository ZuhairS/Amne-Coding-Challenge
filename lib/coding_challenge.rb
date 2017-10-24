# Input
# 5 3
# 188930 194123 201345 154243 154243

# Output
# 3
# 0
# -1

class SalesPattern

  def initialize(input_file = "input.txt")
    input_arr = File.readlines("data/#{input_file}").map(&:strip)
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

    count = 0

    (0...prices.length - 1).each do |idx1|
      (idx1 + 1...prices.length).each do |idx2|
        break unless prices[idx2] > prices[idx2 - 1]
        count += 1
      end
    end

    count
  end

  def count_decreasing_range(prices)
    return 0 if prices.length < 2

    count = 0

    (0...prices.length - 1).each do |idx1|
      (idx1 + 1...prices.length).each do |idx2|
        break unless prices[idx2] < prices[idx2 - 1]
        count += 1
      end
    end

    count
  end

  def print_output(result)
    File.write('data/output.txt', result.join("\n"))
  end

end

if __FILE__ == $PROGRAM_NAME
  SalesPattern.new
end
