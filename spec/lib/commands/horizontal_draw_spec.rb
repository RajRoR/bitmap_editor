require 'spec_helper'

describe Commands::HorizontalDraw do
  let(:app)   { App.new }
  let(:x1)    { '2' }
  let(:x2)    { '3' }
  let(:y)     { '2' }
  let(:color) { 'Z' }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(3, 2).execute(app)
    end

    subject(:hd_new) { described_class.new(x1, x2, y, color) }

    describe '#initialize' do
      it { expect(hd_new.x1).to eq(x1.to_i) }
      it { expect(hd_new.x2).to eq(x2.to_i) }
      it { expect(hd_new.y).to eq(y.to_i) }
      it { expect(hd_new.color).to eq(color) }
    end

    describe '#execute' do
      before { hd_new.execute(app) }

      it { expect(app.bitmap[x1.to_i, y.to_i]).to eq(color) }
      it { expect(app.bitmap[x2.to_i, y.to_i]).to eq(color) }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:hd_create) { described_class.create(x1, x2, y, color) }

        it { expect(hd_create).to       be_a(described_class) }
        it { expect(hd_create.color).to eq(color) }

        context 'integer inputs' do
          it { expect(hd_create.x1).to    eq(x1.to_i) }
          it { expect(hd_create.x2).to    eq(x2.to_i) }
          it { expect(hd_create.y).to     eq(y.to_i)  }
        end
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(y) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { described_class.create('foo', x2, y, color) }.to   raise_error(InvalidArguments) }
        it { expect { described_class.create(x1, 'foo', y, color) }.to   raise_error(InvalidArguments) }
        it { expect { described_class.create(x1, x2, 'foo', color) }.to  raise_error(InvalidArguments) }
        it { expect { described_class.create(x1, x2, y, 'foo') }.to      raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:hd_new) { described_class.new(x1, x2, y, color) }

    describe '#execute' do
      it { expect { hd_new.execute(app) }.to raise_error(MissingBitmap) }
    end
  end
end
