# frozen_string_literal: true

require './specs/spec_helper'
require './input_validation'
require './world'
require './rover'

RSpec.describe InputValidation do
  describe '.world?' do
    context 'when the input is valid' do
      let(:valid_inputs) { ['4 8', '123 123', '0 0', '234 43'] }

      it do
        valid_inputs.each do |input|
          expect(described_class.world?(input)).to be_truthy
        end
      end
    end

    context 'when the input is not valid' do
      let(:invalid_inputs) { ['123', '234 sd', '213, 234', 'sfd sdf', '123 123 123', '1', ''] }

      it do
        invalid_inputs.each do |input|
          expect(described_class.world?(input)).to be_falsy
        end
      end
    end
  end

  describe '.world' do
    let(:input) { '4 8' }

    it { expect(described_class.world(input).x).to eq(4) }
    it { expect(described_class.world(input).y).to eq(8) }
  end

  describe '.rover?' do
    context 'when the input is valid' do
      let(:valid_inputs) { ['(1, 3, S) LL', '(0, 0, N) FRL', '(100, 100, E) FFF', '(2, 2, W)'] }

      it do
        valid_inputs.each do |input|
          expect(described_class.rover?(input)).to be_truthy
        end
      end
    end

    context 'when the input is not valid' do
      let(:invalid_inputs) { ['abc', '1, 3, 5, E', '(1, 3, G)', '(a, 3, N)', '(1, 2, N) ABC'] }

      it do
        invalid_inputs.each do |input|
          expect(described_class.rover?(input)).to be_falsy
        end
      end
    end
  end

  describe '.rover' do
    let(:input) { '(1, 3, S) LL' }

    it { expect(described_class.rover(input).x).to eq(1) }
    it { expect(described_class.rover(input).y).to eq(3) }
    it { expect(described_class.rover(input).heading).to eq('S') }
  end

  describe '.sequence_of_movements' do
    let(:input) { '(1, 3, S) LL' }

    it { expect(described_class.sequence_of_movements(input)).to eq(['L', 'L']) }
  end
end
