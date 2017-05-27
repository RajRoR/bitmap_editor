require 'spec_helper'

describe Commands::HorizontalDraw do
  let(:app)   { App.new }
  let(:x1)    { '2' }
  let(:x2)    { '3' }
  let(:y)     { '2' }
  let(:color) { 'Z' }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 3, 2).execute
    end

    subject { Commands::HorizontalDraw.new(app, x1, x2, y, color) }

    describe '#initialize' do
      it { expect(subject.app).to eq(app) }
      it { expect(subject.x1).to eq(x1.to_i) }
      it { expect(subject.x2).to eq(x2.to_i) }
      it { expect(subject.y).to eq(y.to_i) }
      it { expect(subject.color).to eq(color) }
    end

    describe '#execute' do
      before { subject.execute }

      it { expect(app.bitmap[x1.to_i, y.to_i]).to eq(color) }
      it { expect(app.bitmap[x2.to_i, y.to_i]).to eq(color) }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject { Commands::HorizontalDraw.create(app, x1, x2, y, color) }

        it { expect(subject).to       be_a(Commands::HorizontalDraw) }
        it { expect(subject.x1).to    eq(x1.to_i) }
        it { expect(subject.x2).to    eq(x2.to_i) }
        it { expect(subject.y).to     eq(y.to_i)  }
        it { expect(subject.color).to eq(color)   }
      end

      context 'with wrong number of arguments' do
        it { expect { Commands::HorizontalDraw.create(app, y) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { Commands::HorizontalDraw.create(app, 'foo', x2, y, color) }.to   raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, 'foo', y, color) }.to   raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, x2, 'foo', color) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, x2, y, 'foo') }.to      raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject { Commands::HorizontalDraw.new(app, x1, x2, y, color) }

    describe '#execute' do
      it { expect { subject.execute }.to raise_error(MissingBitmap) }
    end
  end
end
