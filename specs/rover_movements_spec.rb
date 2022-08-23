# frozen_string_literal: true

require './specs/spec_helper'
require './rover'
require './rover_movements'
require './world'

RSpec.describe RoverMovements do
  let(:rover_movements) do
    described_class.new(
      world: world,
      rover: rover,
      sequence_of_movements: sequence_of_movements
    )
  end

  describe '#validations' do
    describe '#valid_world?' do
      let(:rover) { Rover.new(x: 1, y: 1, heading: 'S') }
      let(:sequence_of_movements) { ['L', 'L', 'R', 'F'] }

      context 'when world is invalid' do
        let(:world) { World.new(x: 'dsfsdf', y: nil) }

        it 'RoverMovements is invalid' do
          expect(rover_movements.valid?).to be_falsy
        end
      end

      context 'when world is valid' do
        let(:world) { World.new(x: 4, y: 8) }

        it 'RoverMovements is valid' do
          expect(rover_movements.valid?).to be_truthy
        end
      end
    end

    describe '#valid_rover?' do
      let(:world) { World.new(x: 10, y: 10) }
      let(:sequence_of_movements) { ['L', 'L', 'R', 'F'] }

      context 'when rover is invalid' do
        let(:rover) { Rover.new(x: 1, y: 1, heading: 'A') }

        it 'RoverMovements is invalid' do
          expect(rover_movements.valid?).to be_falsy
        end
      end

      context 'when rover is valid' do
        let(:rover) { Rover.new(x: 1, y: 1, heading: 'S') }

        it 'RoverMovements is valid' do
          expect(rover_movements.valid?).to be_truthy
        end
      end
    end

    describe '#valid_sequence_of_movements?' do
      let(:world) { World.new(x: 10, y: 10) }
      let(:rover) { Rover.new(x: 1, y: 1, heading: 'S') }

      context 'when sequence_of_movements is invalid' do
        let(:sequence_of_movements) { ['L', 'L', 'A', 'F'] }

        it 'RoverMovements is invalid' do
          expect(rover_movements.valid?).to be_falsy
        end
      end

      context 'when sequence_of_movements is valid' do
        let(:sequence_of_movements) { ['L', 'L', 'R', 'F'] }
        it 'RoverMovements is valid' do
          expect(rover_movements.valid?).to be_truthy
        end
      end
    end

    describe '#execute' do
      let(:world) { World.new(x: 4, y: 8) }
      let(:rover_one) { Rover.new(x: 2, y: 3, heading: 'E') }
      let(:rover_two) { Rover.new(x: 0, y: 2, heading: 'N') }
      let(:rover_three) { Rover.new(x: 2, y: 3, heading: 'N') }
      let(:rover_four) { Rover.new(x: 1, y: 0, heading: 'S') }
      let(:seq_one) { ['L', 'F', 'R', 'F', 'F'] }
      let(:seq_two) { ['F', 'F', 'L', 'F', 'R', 'F', 'F'] }
      let(:seq_three) { ['F', 'L', 'L', 'F', 'R'] }
      let(:seq_four) { ['F', 'F', 'R', 'L', 'F'] }
      let(:result_one) { { last_known_position: { x: 4, y: 4, heading: 'E' }, lost: false } }
      let(:result_two) { { last_known_position: { x: 0, y: 4, heading: 'W' }, lost: true } }
      let(:result_three) { { last_known_position: { x: 2, y: 3, heading: 'W' }, lost: false } }
      let(:result_four) { { last_known_position: { x: 1, y: 0, heading: 'S' }, lost: true } }

      it 'calculate the final path' do
        ['one', 'two', 'three', 'four'].each do |i|
          rover_movements = RoverMovements.new(
            world: world,
            rover: send("rover_#{i}"),
            sequence_of_movements: send("seq_#{i}")
          )
          results = rover_movements.execute!.slice(:last_known_position, :lost)

          expect(results).to eq(send("result_#{i}"))
        end
      end
    end
  end
end
