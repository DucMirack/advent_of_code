class Measurement
  attr_reader :value, :index

  def initialize(value, index)
    @value = value
    @index = index
  end

  def superior_to_previous?
    value > previous_measurement
  end

  def inferior_to_previous?
    value < previous_measurement
  end

  def previous_measurement(step = 1)
    Measurement.new(Datas::MEASUREMENTS[index - step], index - step)
  end

  def next_measurement(step = 1)
    Measurement.new(Datas::MEASUREMENTS[index + step], index + step)
  end

  def sum_of_sliding_measurements
    values_sum = value
    values_sum += next_measurement.value
    values_sum += next_measurement(2).value
    values_sum
  end

  def first?
    index == 0
  end

  def in_last?(limit = 1)
    (1..limit).each do |i|
      return true if index == (Datas::MEASUREMENTS.length - i)
    end
    false
  end
end
