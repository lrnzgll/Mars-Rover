# frozen_string_literal: true

require './world'
require './rover'

class InputValidation
  def self.world?(world_input)
    world_input.match?(/^(\d+\s)\d+$/)
  end

  def self.world(world_input)
    world_input.scan(/\d+/).then do |x|
      World.new(x: x[0].to_i, y: x[1].to_i)
    end
  end

  def self.rover?(rover_input)
    rover_input.match?(/^\(\d+,\s\d+,\s(N|S|W|E)\)\s?[LFR]{0,}$/)
  end

  def self.rover(rover_input)
    coordinates = rover_input.scan(/\d+/)
    heading = rover_input.scan(/[N|W|S|E|]/).first

    Rover.new(
      x: coordinates[0].to_i,
      y: coordinates[1].to_i,
      heading: heading
    )
  end

  def self.sequence_of_movements(rover_input)
    rover_input.scan(/[LFR]/)
  end
end
