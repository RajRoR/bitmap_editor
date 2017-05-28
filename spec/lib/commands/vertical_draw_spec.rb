require 'spec_helper'

describe Commands::VerticalDraw do
  let(:app)   { App.new }
  let(:x)     { '2' }
  let(:y1)    { '1' }
  let(:y2)    { '3' }
  let(:color) { 'W' }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 3).execute
    end

    subject(:vd_new) { described_class.new(app, x, y1, y2, color) }

    describe '#initialize' do
      it { expect(vd_new.app).to eq(app) }
      it { expect(vd_new.x).to eq(x.to_i) }
      it { expect(vd_new.y1).to eq(y1.to_i) }
      it { expect(vd_new.y2).to eq(y2.to_i) }
      it { expect(vd_new.color).to eq(color) }
    end

    describe '#execute' do
      before { vd_new.execute }

      it { expect(app.bitmap[x.to_i, y1.to_i]).to eq(color) }
      it { expect(app.bitmap[x.to_i, y2.to_i]).to eq(color) }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:vd_create) { described_class.create(app, x, y1, y2, color) }

        it { expect(vd_create).to       be_a(described_class) }
        it { expect(vd_create.x).to     eq(x.to_i) }
        it { expect(vd_create.y1).to    eq(y1.to_i) }
        it { expect(vd_create.y2).to    eq(y2.to_i) }
        it { expect(vd_create.color).to eq(color) }
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(app, x) }.to raise_error(BadNumberArguments) }
      end

      context 'with bad type of arguments' do
        it { expect { described_class.create(app, 'foo', y1, y2, color) }.to raise_error(InvalidArguments) }
        it { expect { described_class.create(app, x, 'foo', y2, color) }.to  raise_error(InvalidArguments) }
        it { expect { described_class.create(app, x, y1, 'foo', color) }.to  raise_error(InvalidArguments) }
        it { expect { described_class.create(app, x, y1, y2, 'foo') }.to raise_error(InvalidArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:vd_new) { described_class.new(app, x, y1, y2, color) }

    describe '#execute' do
      it { expect { vd_new.execute }.to raise_error(MissingBitmap) }
    end
  end
end
