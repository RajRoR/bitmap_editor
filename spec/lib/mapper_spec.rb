require 'spec_helper'

describe Mapper do
  let(:app) { App.new }

  subject { Mapper.new(app) }

  describe '#initialize' do
    it { expect(subject.app).to eq(app) }
  end

  describe '#map' do
    context 'with valid commands' do
      it { expect(subject.map('I 5 6')).to     be_a(Commands::Create) }
      it { expect(subject.map('L 2 3 A')).to   be_a(Commands::ColorPixel) }
      it { expect(subject.map('V 1 2 3 J')).to be_a(Commands::VerticalDraw) }
      it { expect(subject.map('H 1 2 3 J')).to be_a(Commands::HorizontalDraw) }
      it { expect(subject.map('C')).to         be_a(Commands::Clear) }
      it { expect(subject.map('S')).to         be_a(Commands::Show) }
    end

    context 'with invalid commands' do
      it { expect { subject.map('foo') }.to raise_error(InvalidCommand) }
    end
  end
end
