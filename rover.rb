# frozen_string_literal: true
require 'active_model'

HEADING = ['N', 'E', 'S', 'W']

class Rover
  include ActiveModel::Validations

  InvalidNextMove = Class.new(StandardError)

  attr_reader :x, :y, :heading

  def initialize(x:, y:, heading:)
    @x = x
    @y = y
    @heading = heading
    @positions = []
  end

  validates :x, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :y, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :heading, inclusion: { in: HEADING, message: "%{value} is not a valid heading. (N,E,S,W)"}

  def move(next_move)
    raise(InvalidNextMove, "#{next_move} is not a valid move. Please use: L, R, F") unless next_move_is_valid?(next_move)

    new_position(next_move)
  end

  def current_position
    {
      x: x,
      y: y,
      heading: heading,
    }
  end

  private

  def new_position(next_move)
    @positions << current_position

    case next_move
    when 'L'
      move_heading_left
    when 'R'
      move_heading_right
    when 'F'
      move_forward
    end

    current_position
  end

  def move_forward
    case heading
    when 'N'
      self.y += 1
    when 'S'
      self.y -= 1
    when 'E'
      self.x += 1
    when 'W'
      self.x -= 1
    end
  end

  def move_heading_left
    index = HEADING.index(@heading)
    new_heading = HEADING.rotate(-1)[index]

    self.heading = new_heading
  end

  def move_heading_right
    index = HEADING.index(@heading)
    new_heading = HEADING.rotate[index]

    self.heading = new_heading
  end

  def next_move_is_valid?(next_move)
    ['F', 'L', 'R'].include?(next_move)
  end

  def x=(new_x)
    @x = new_x
  end

  def y=(new_y)
    @y = new_y
  end

  def heading=(new_heading)
    @heading = new_heading
  end
end
