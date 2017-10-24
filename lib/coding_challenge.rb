class SalesPattern

  def initialize(input_file = "default_input.txt")
    input_arr = File.readlines("data/#{input_file}").map(&:strip)
    @num_of_days, @window_size = input_arr.first.split(" ").map(&:to_i)
    @sale_prices = input_arr.last.split(" ").map(&:to_i)
    find_pattern
  end

  # Overall logic flow
  def find_pattern
    result = []

    # Get increasing and decreasing subrange counts for specified
    # window size for every element within acceptable window range
    @sale_prices[0..-@window_size].each_index do |idx|
      increasing_count = count_increasing_range(@sale_prices[idx...idx + @window_size])
      decreasing_count = count_decreasing_range(@sale_prices[idx...idx + @window_size])

      result << increasing_count - decreasing_count
    end

    print_output(result)
  end

  private

  # Counts total increasing subranges by keeping track of increasing
  # subarrays and using the fact that there are sum(1..n) number of
  # increasing subranges within one such subarray
  # Time complexity of O(k), Space complexity O(1)
  def count_increasing_range(prices)
    return 0 if prices.length < 2

    total_count, curr_count = 0, 0

    prices.each_with_index do |price, idx|
      next if idx == 0
      if price > prices[idx - 1]
        curr_count += 1
      else
        total_count += range_summation(curr_count)
        curr_count = 0
      end
    end

    total_count += range_summation(curr_count)
    total_count
  end

  # Same as before but for decreasing ranges
  def count_decreasing_range(prices)
    return 0 if prices.length < 2

    total_count, curr_count = 0, 0

    prices.each_with_index do |price, idx|
      next if idx == 0
      if price < prices[idx - 1]
        curr_count += 1
      else
        total_count += range_summation(curr_count)
        curr_count = 0
      end
    end

    total_count += range_summation(curr_count)
    total_count
  end

  # Efficiently calculates total sum of range 1..num
  def range_summation(num)
    num * (num + 1) / 2
  end

  def print_output(result)
    File.write('data/output.txt', result.join("\n"))
  end

end

if __FILE__ == $PROGRAM_NAME
  SalesPattern.new
end
