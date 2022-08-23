# frozen_string_literal: true

require './rover_movements'
require './input_validation'

class Main
  def self.call
    new.call
  end

  def call
    runner do
      remove_instance_variable(:@world) if defined?(@world)
      @rover_movements = []
      loop do
        set_world
        set_rover
        @rover_movements << RoverMovements.new(world: @world, rover: @rover, sequence_of_movements: @movements)

        puts 'Click "y" to add another rover?'
        new_rover = gets.chomp
        break unless new_rover == 'y'
      end
      @rover_movements.each do |rover_movement|
        rover_movement.execute!
        puts "(#{rover_movement.last_known_position[:x]}, "\
             "#{rover_movement.last_known_position[:y]}, "\
             "#{rover_movement.last_known_position[:heading]}) "\
             "#{"LOST" if rover_movement.lost}"
      end
    end
  end


  private

  def set_world
    return @world if defined?(@world)

    loop do
      puts 'What is the size of the world?'
      puts 'example: 4 8'
      world_input = gets.chomp
      unless InputValidation.world?(world_input)
        puts 'Incorrect format, please retry'
        next
      end

      @world = InputValidation.world(world_input)
      break
    end
  end

  def set_rover
    loop do
      puts 'Please add initial position, heading and sequence of movements for the rover'
      puts 'example: (4, 4, E) LFRL'
      rover_input = gets.chomp
      unless InputValidation.rover?(rover_input)
        puts 'Incorrect format, please retry'
        next
      end

      @rover = InputValidation.rover(rover_input)
      @movements = InputValidation.sequence_of_movements(rover_input)
      break
    end
  end

  def runner
    loop do
      puts "\e[H\e[2J"
      puts '# MARS ROVER Project'
      puts '####################'
      puts

      yield

      puts 'Press "y" to restart the program?'
      restart_program = gets.chomp
      break unless restart_program == 'y'
    end
  end
end

Main.call
