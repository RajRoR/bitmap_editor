require 'spec_helper'

describe Commands::ColorPixel do
  let(:x)     { '1' }
  let(:y)     { '2' }
  let(:color) { 'A' }
  let(:app)   { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject { Commands::ColorPixel.new(app, x, y, color) }

    describe '#initialize' do
      it { expect(subject.app).to eq(app) }
      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y).to eq(y.to_i) }
      it { expect(subject.color).to eq(color) }
    end

    describe '#execute' do
      it { expect { subject.execute }.to change { app.bitmap.data }.from('OOOO').to('OOAO') }
    end

    describe '#create' do
      context 'when correct arguments' do
        subject { Commands::ColorPixel.create(app, x, y, color) }

        it { expect(subject).to be_a(Commands::ColorPixel) }
        it { expect(subject.x).to eq(x.to_i) }
        it { expect(subject.y).to eq(y.to_i) }
        it { expect(subject.color).to eq(color) }
      end

      context 'with wrong number of arguments' do
        it { expect { Commands::ColorPixel.create(app, x) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { Commands::ColorPixel.create(app, x, 'foo', color) }.to raise_error(InvalidArguments) }
        it { expect { Commands::ColorPixel.create(app, 'foo', y, color) }.to raise_error(InvalidArguments) }
        it { expect { Commands::ColorPixel.create(app, x, y, 'foo') }.to raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject { Commands::ColorPixel.new(app, x, y, color) }

    describe '#execute' do
      it { expect { subject.execute }.to raise_error(MissingBitmap) }
    end
  end
end
