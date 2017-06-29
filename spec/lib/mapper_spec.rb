require 'spec_helper'

describe Mapper do
  subject(:mapper) { described_class.new }

  let(:app) { App.new }

  describe '#map' do
    context 'with valid commands' do
      it { expect(mapper.map('I 5 6')).to       be_a(Commands::Create) }
      it { expect(mapper.map('L 2 3 A')).to     be_a(Commands::ColorPixel) }
      it { expect(mapper.map('V 1 2 3 J')).to   be_a(Commands::VerticalDraw) }
      it { expect(mapper.map('H 1 2 3 J')).to   be_a(Commands::HorizontalDraw) }
      it { expect(mapper.map('F 3 3 R')).to     be_a(Commands::FillRegion) }
      it { expect(mapper.map('O 1 2 4 5 X')).to be_a(Commands::Outline) }
      it { expect(mapper.map('C')).to           be_a(Commands::Clear) }
      it { expect(mapper.map('S')).to           be_a(Commands::Show) }
    end

    context 'with invalid commands' do
      it { expect { mapper.map('foo') }.to raise_error(InvalidCommand) }
    end
  end
end