require 'rspec'
require 'coding_challenge'

# Currently these tests modify the actual output file but can be made to
# run independently
describe SalesPattern do

  it "gives correct output in the default case" do
    SalesPattern.new

    test_output = File.readlines("data/output.txt").map(&:strip)
    sample_output = ["3", "0", "-1"]

    expect(test_output).to match_array(sample_output)
  end

  it "gives correct output for all increasing" do
    SalesPattern.new("test_input1.txt")

    test_output = File.readlines("data/output.txt").map(&:strip)
    sample_output = ["6", "6", "6"]

    expect(test_output).to match_array(sample_output)

  end

  it "gives correct output for all decreasing values" do
    SalesPattern.new("test_input2.txt")

    test_output = File.readlines("data/output.txt").map(&:strip)
    sample_output = ["3", "3", "3", "3"]

    expect(test_output).to match_array(sample_output)

  end

  it "gives correct output in custom cases" do
    SalesPattern.new("test_input3.txt")

    test_output = File.readlines("data/output.txt").map(&:strip)
    sample_output = ["6", "4", "6", "5", "2"]

    expect(test_output).to match_array(sample_output)

  end

  it "runs in less than 30 seconds for big valid input size" do
    start_time = Time.new
    SalesPattern.new("test_input_large.txt")
    end_time = Time.new

    runtime = end_time - start_time

    expect(runtime).to be < 30
  end

end
