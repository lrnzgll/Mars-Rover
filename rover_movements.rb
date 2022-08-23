# frozen_string_literal: true

require 'active_model'
require './world'
require './rover'

class RoverMovements
  include ActiveModel::Validations

  attr_reader :world, :rover, :sequence_of_movements, :last_known_position, :lost
  def initialize(world:, rover:, sequence_of_movements:)
    @world = world
    @rover = rover
    @sequence_of_movements = sequence_of_movements
    @last_known_position = rover.current_position
    @lost = false
  end

  validate :valid_world?
  validate :valid_rover?
  validate :valid_sequence_of_movements?

  def execute!
    calculate_path

    {
      last_known_position: @last_known_position,
      lost: @lost,
    }
  end

  private

  def calculate_path
    @sequence_of_movements.each do |movement|
      @rover.move(movement)

      break if rover_lost?

      @last_known_position = @rover.current_position
    end
  end

  def rover_lost?
    @lost =  @world.out_of_world?(@rover)
  end

  def valid_world?
    world.valid? || errors.add(:world, "Invalid World: #{world.errors.full_messages}")
  end

  def valid_rover?
    rover.valid? || errors.add(:rover, "Invalid Rover: #{rover.errors.full_messages}")
  end

  def valid_sequence_of_movements?
    unless sequence_of_movements.all? { |movement| ['L', 'R', 'F'].include?(movement) }
      errors.add(:rover, "Invalid Sequence of movements: valid movements are L, F, R")
    end
  end
end
