require 'spec_helper'

describe Commands::VerticalDraw do
  let(:app)    { App.new }
  let(:x)      { '2' }
  let(:y1)     { '1' }
  let(:y2)     { '3' }
  let(:color) { 'W' }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 3).execute
    end

    subject { Commands::VerticalDraw.new(app, x, y1, y2, color) }

    describe '#initialize' do
      it { expect(subject.app).to eq(app) }
      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y1).to eq(y1.to_i) }
      it { expect(subject.y2).to eq(y2.to_i) }
      it { expect(subject.color).to eq(color) }
    end

    describe '#execute' do
      before { subject.execute }

      it { expect(app.bitmap[x.to_i, y1.to_i]).to eq(color) }
      it { expect(app.bitmap[x.to_i, y2.to_i]).to eq(color) }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject { Commands::VerticalDraw.create(app, x, y1, y2, color) }

        it { expect(subject).to       be_a(Commands::VerticalDraw) }
        it { expect(subject.x).to     eq(x.to_i) }
        it { expect(subject.y1).to    eq(y1.to_i) }
        it { expect(subject.y2).to    eq(y2.to_i) }
        it { expect(subject.color).to eq(color) }
      end

      context 'with wrong number of arguments' do
        it { expect { Commands::VerticalDraw.create(app, x) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { Commands::VerticalDraw.create(app, 'foo', y1, y2, color) }.to raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, 'foo', y2, color) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, y1, 'foo', color) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, y1, y2, 'foo') }.to raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject { Commands::VerticalDraw.new(app, x, y1, y2, color) }

    describe '#execute' do
      it { expect { subject.execute }.to raise_error(MissingBitmap) }
    end
  end
end
