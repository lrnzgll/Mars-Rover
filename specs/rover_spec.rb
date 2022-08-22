# frozen_string_literal: true

require './specs/spec_helper.rb'
require './rover.rb'

RSpec.describe Rover do
  let(:rover) { Rover.new(x: x, y: y, heading: heading) }

  context 'validations' do
    describe '#x' do
      let(:y) { 0 }
      let(:heading) { 'N' }

      context 'when #x is an integer' do
        let(:x) { 0 }
        it 'rover is valid' do
          expect(rover.valid?).to be_truthy
        end
      end

      context 'when #x is not an integer or is negative' do
        ['a', 1.123, nil, '', -4].each do |x|
          let(:x) { x }
          it 'rover is invalid' do
            expect(rover.valid?).to be_falsy
          end
        end
      end
    end

    describe '#y' do
      let(:x) { 0 }
      let(:heading) { 'N' }

      context 'when #y is an integer' do
        let(:y) { 0 }
        it 'rover is valid' do
          expect(rover.valid?).to be_truthy
        end
      end

      context 'when #y is not an integer or is negative' do
        ['a', 1.123, nil, '', -5].each do |y|
          let(:y) { y }
          it 'rover is invalid' do
            expect(rover.valid?).to be_falsy
          end
        end
      end
    end

    describe '#heading' do
      let(:x) { 0 }
      let(:y) { 0 }

      context 'when #heading is one of (N,E,S,W)' do
        ['N', 'E', 'S', 'W'].each do |heading|
          let(:heading) { heading }

          it 'rover is valid' do
            expect(rover.valid?).to be_truthy
          end
        end
      end

        context 'when #heading is not included in (N,E,S,W)' do
        ['a', 1.123, nil, 'n', ''].each do |heading|
          let(:heading) { heading }
          it 'rover is invalid' do
            expect(rover.valid?).to be_falsy
          end
        end
      end
    end

    describe '#position' do
      let(:rover) { Rover.new(x: 10, y: 5, heading: 'N') }

      it 'return the rover position' do
#        expect(rover.position).to eq({x: 10, y: 5, heading: 'N'})
      end
    end

    describe '#move' do
      let(:x) { 5 }
      let(:y) { 5 }
      let(:heading) { 'N' }

      context 'when the next move is invalid' do
        it 'raises and InvalidNextMove error' do
          expect { rover.move('d') }.to raise_error(Rover::InvalidNextMove)
        end
      end

      context 'when the next move is "L"' do
        it 'heading changes anticlockwise' do
          expect(rover.heading).to eq('N')
          rover.move('L')
          expect(rover.heading).to eq('W')
          rover.move('L')
          expect(rover.heading).to eq('S')
          rover.move('L')
          expect(rover.heading).to eq('E')
        end
      end

      context 'when the next move is "R"' do
        it 'heading changes clockwise' do
          expect(rover.heading).to eq('N')
          rover.move('R')
          expect(rover.heading).to eq('E')
          rover.move('R')
          expect(rover.heading).to eq('S')
          rover.move('R')
          expect(rover.heading).to eq('W')
        end
      end

      context 'when the next move is "F"' do
        let(:y) { 5 }
        let(:x) { 5 }

        context 'when heading is N' do
          let(:heading) { 'N' }

          it 'moves towards north' do
            expect(rover.y).to eq(y)
            rover.move('F')
            expect(rover.y).to eq(y + 1)
          end
        end

        context 'when heading is W' do
          let(:heading) { 'W' }

          it 'moves towards west' do
            expect(rover.x).to eq(x)
            rover.move('F')
            expect(rover.x).to eq(x - 1)
          end
        end

        context 'when heading is E' do
          let(:heading) { 'E' }

          it 'moves towards east' do
            expect(rover.x).to eq(x)
            rover.move('F')
            expect(rover.x).to eq(x + 1)
          end
        end

        context 'when heading is S' do
          let(:heading) { 'S' }

          it 'moves towards south' do
            expect(rover.y).to eq(y)
            rover.move('F')
            expect(rover.y).to eq(y - 1)
          end
        end
      end
    end
  end
end
