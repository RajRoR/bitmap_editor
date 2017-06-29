require 'spec_helper'

describe Commands::FillRegion do
  let(:app)   { App.new }
  let(:x)     { '3' }
  let(:y)     { '3' }
  let(:color) { 'R' }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(3, 3).execute(app)
    end

    subject(:fill) { described_class.new(x, y, color) }

    describe '#initialize' do
      it { expect(fill.x).to eq(x.to_i) }
      it { expect(fill.y).to eq(y.to_i) }
      it { expect(fill.color).to eq(color) }
    end

    describe '#execute' do
      before { app.bitmap[2, 2] = 'A' }

      it { expect { fill.execute(app) }.to change { app.bitmap.data }.from('OOOOAOOOO').to('RRRRARRRR')  }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:fill_create) { described_class.create(x, y, color) }

        it { expect(fill_create).to       be_a(described_class) }
        it { expect(fill_create.color).to eq(color) }

        context 'integer inputs' do
          it { expect(fill_create.x).to     eq(x.to_i) }
          it { expect(fill_create.y).to     eq(y.to_i)  }
        end
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(app, y) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { described_class.create('foo', y, color) }.to   raise_error(InvalidArguments) }
        it { expect { described_class.create(x, 'foo', color) }.to   raise_error(InvalidArguments) }
        it { expect { described_class.create(x, y, 'foo') }.to       raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:fill_new) { described_class.new(x, y, color) }

    describe '#execute' do
      it { expect { fill_new.execute(app) }.to raise_error(MissingBitmap) }
    end
  end
end
