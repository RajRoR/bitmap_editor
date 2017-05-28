require 'spec_helper'

describe Bitmap do
  subject(:bitmap) { described_class.new(width, height) }

  let(:width)  { 2 }
  let(:height) { 2 }

  describe '#initialize' do
    it { expect(bitmap.width).to eq(width) }
    it { expect(bitmap.height).to eq(height) }
    it { expect(bitmap.data).to eq('O' * width * height) }
  end

  describe '#clear' do
    before { bitmap[1, 1] = 'A' }

    it { expect { bitmap.clear }.to change { bitmap.data }.from('AOOO').to('OOOO') }
  end

  describe '#[]=' do
    context 'when coordinates are valid' do
      it { expect { bitmap[1, 1] = 'A' }.to change { bitmap.data }.from('OOOO').to('AOOO') }
    end

    context 'when coordinates are invalid' do
      it { expect { bitmap[0, 1] = 'A' }.to raise_error(OutOfRange) }
    end
  end

  describe '#[]' do
    context 'with valid coordinates' do
      before do
        bitmap[1, 2] = 'A'
      end

      it { expect(bitmap[1, 2]).to eq('A') }
    end

    context 'with invalid coordinates' do
      it { expect { bitmap[0, 1] }.to raise_error(OutOfRange) }
    end
  end

  describe '#check_range' do
    context 'with correct coordinates' do
      it { expect(bitmap.check_range(1, 1)).to eq(true) }
    end

    context 'with incorrect coordinates' do
      it { expect(bitmap.check_range(0, 1)).to eq(false) }
      it { expect(bitmap.check_range(1, 0)).to eq(false) }
      it { expect(bitmap.check_range(3, 1)).to eq(false) }
      it { expect(bitmap.check_range(1, 3)).to eq(false) }
    end
  end

  describe '#index' do
    it { expect(bitmap.index(1, 2)).to eq(2) }
  end
end
