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

    subject(:cp_new) { described_class.new(app, x, y, color) }

    describe '#initialize' do
      it { expect(cp_new.app).to eq(app) }
      it { expect(cp_new.x).to eq(x.to_i) }
      it { expect(cp_new.y).to eq(y.to_i) }
      it { expect(cp_new.color).to eq(color) }
    end

    describe '#execute' do
      it { expect { cp_new.execute }.to change { app.bitmap.data }.from('OOOO').to('OOAO') }
    end

    describe '#create' do
      context 'when correct arguments' do
        subject(:cp_create) { described_class.create(app, x, y, color) }

        it { expect(cp_create).to be_a(described_class) }
        it { expect(cp_create.x).to eq(x.to_i) }
        it { expect(cp_create.y).to eq(y.to_i) }
        it { expect(cp_create.color).to eq(color) }
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(app, x) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { described_class.create(app, x, 'foo', color) }.to raise_error(InvalidArguments) }
        it { expect { described_class.create(app, 'foo', y, color) }.to raise_error(InvalidArguments) }
        it { expect { described_class.create(app, x, y, 'foo') }.to raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:cp_new) { described_class.new(app, x, y, color) }

    describe '#execute' do
      it { expect { cp_new.execute }.to raise_error(MissingBitmap) }
    end
  end
end
