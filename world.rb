# frozen_string_literal: true

require 'active_model'

class World
  include ActiveModel::Validations

  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  validates :x, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :y, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def out_of_world?(rover)
    (rover.x.negative? || rover.x > @x) ||
      (rover.y.negative? || rover.y > @y)
  end
end
