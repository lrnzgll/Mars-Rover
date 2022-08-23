# frozen_string_literal: true

require './specs/spec_helper.rb'
require './world.rb'
require './rover.rb'

RSpec.describe World do
  let(:world) { World.new(x: x, y: y) }

  context 'validations' do
    describe '#x' do
      let(:y) { 0 }

      context 'when #x is an integer' do
        let(:x) { 0 }
        it 'world is valid' do
          expect(world.valid?).to be_truthy
        end
      end

      context 'when #x is not an integer or less than 0' do
        ['a', 1.123, nil, '', -34].each do |x|
          let(:x) { x }
          it 'world is invalid' do
            expect(world.valid?).to be_falsy
          end
        end
      end
    end

    describe '#y' do
      let(:x) { 0 }
      let(:heading) { 'N' }

      context 'when #y is an integer' do
        let(:y) { 0 }
        it 'world is valid' do
          expect(world.valid?).to be_truthy
        end
      end

      context 'when #y is not an integer or less than 0' do
        ['a', 1.123, nil, '', -12].each do |y|
          let(:y) { y }
          it 'world is invalid' do
            expect(world.valid?).to be_falsy
          end
        end
      end
    end
  end

  describe '#out_of_world?' do
    let(:x) { 5 }
    let(:y) { 5 }

    context 'when the rover is outside of world' do
      it 'is true' do
        [
          Rover.new(x: -1, y: 1, heading: 'N'),
          Rover.new(x: 1, y: -1, heading: 'N'),
          Rover.new(x: 6, y: 2, heading: 'N'),
          Rover.new(x: 2, y: 6, heading: 'N'),
          Rover.new(x: -1, y: -1, heading: 'N'),
          Rover.new(x: 6, y: 6, heading: 'N'),
        ].each do |rover|
          expect(world.out_of_world?(rover)).to be_truthy
        end
      end
    end
    context 'when the rover is in the world' do
      it 'is false' do
        [
          Rover.new(x: 0, y: 0, heading: 'N'),
          Rover.new(x: 5, y: 5, heading: 'N'),
          Rover.new(x: 3, y: 2, heading: 'N'),
        ].each do |rover|
          expect(world.out_of_world?(rover)).to be_falsy
        end
      end
    end
  end
end
