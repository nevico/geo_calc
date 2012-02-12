# load File.dirname(__FILE__) + '/../lib/geo_calc.rb'
require "benchmark"
require_relative '../lib/geo_calc'


X = 1
Y = 2
COLUMN_LENGTH = 30

def generate_data(number)
  data = []
  number.times do
    data << generate_set
  end
  data
end

def generate_set
  [generate_number, generate_number(Y)]
end

def generate_number(coordinate = X)
  number = rand(180)
  number = number / 2 if coordinate == Y
  number * -1 if rand(2) == 1
  number.to_f
end

def puts_results(data_size, results)
  puts "#{data_size} " + "-"*(120 - data_size.to_s.length)
  results.each do |key, value|
    puts "#{key.capitalize} center".ljust(COLUMN_LENGTH) +
      "#{value[:time]}".ljust(COLUMN_LENGTH) +
      "#{value[:result].to_a}".ljust(COLUMN_LENGTH) 
  end
  puts
  puts
end

[10, 100, 1_000, 10_000, 100_000].each do |number|
  data = generate_data(number)
  geo_calc = GeoCalc.new
  cartesian_time = Benchmark.realtime do
    @cartesian_result = geo_calc.cartesian_center(data)
  end
  
  vector_time = Benchmark.realtime do
    @vector_result = geo_calc.vector_center(data)
  end
  
  bounds_time = Benchmark.realtime do
    @bounds_result = geo_calc.bounds_center(data)
  end
  
  puts_results( data.length,
    :cartesian => { :time => cartesian_time, :result => @cartesian_result },
    :vector => { :time => vector_time, :result => @vector_result },
    :bounds => { :time => bounds_time, :result => @bounds_result }
  )
end

