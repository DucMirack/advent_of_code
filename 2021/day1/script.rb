require_relative 'datas'
require_relative 'measurement'
require 'byebug'

class Script
  class Part1
    def self.process
      depth_measurement_increase = 0
      Datas::MEASUREMENTS.each_with_index do |value, index|
        measurement = Measurement.new(value, index)
        measurement_string = "#{measurement.value}"
        if measurement.first?
          measurement_string << " (N/A - no previous measurement)"
        elsif measurement.superior_to_previous?
          measurement_string << " (increased)"
          depth_measurement_increase += 1
        elsif measurement.inferior_to_previous?
          measurement_string << " (decreased)"
        else
          measurement_string << " (unchanged)"
        end
        puts measurement_string
      end
      puts depth_measurement_increase
    end
  end

  class Part2
    def self.process
      depth_measurement_increase = 0
      Datas::MEASUREMENTS.each_with_index do |value, index|
        measurement_string = ""
        measurement = Measurement.new(value, index)
        # Sum measurement
        if measurement.first?
          current_measurement_sum_values = measurement.sum_of_sliding_measurements
          measurement_string << " #{current_measurement_sum_values}"
          measurement_string << " (N/A - no previous sum)"
        elsif measurement.in_last?(2)
          measurement_string << " (N/A - no possible sum)"
        else
          current_measurement_sum_values = measurement.sum_of_sliding_measurements
          measurement_string << " #{current_measurement_sum_values}"
          previous_measurement = measurement.previous_measurement
          previous_measurement_sum_values = previous_measurement.sum_of_sliding_measurements
          if current_measurement_sum_values > previous_measurement_sum_values
            measurement_string << " (increased)"
            depth_measurement_increase += 1
          elsif current_measurement_sum_values < previous_measurement_sum_values
            measurement_string << " (decreased)"
          else
            measurement_string << " (unchanged)"
          end
        end
        measurement_string << "\n"
        puts measurement_string
      end
      puts depth_measurement_increase
    end
  end
end

# Script::Part1.process
Script::Part2.process
