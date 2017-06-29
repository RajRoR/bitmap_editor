require 'spec_helper'

describe Commands::Create do
  subject(:create_new) { described_class.new(width, height) }

  let(:app)    { App.new }
  let(:width)  { '2' }
  let(:height) { '2' }

  describe '#initialize' do
    it { expect(create_new.width).to eq(width.to_i) }
    it { expect(create_new.height).to eq(height.to_i) }
  end

  describe '#execute' do
    before { create_new.execute(app) }

    it { expect(app.bitmap).to be_a(Bitmap) }
    it { expect(app.bitmap.width).to eq(width.to_i) }
    it { expect(app.bitmap.height).to eq(height.to_i) }
  end

  describe '#create' do
    context 'with correct arguments' do
      subject(:create) { described_class.create(width, height) }

      it { expect(create).to be_a(described_class) }
      it { expect(create.width).to eq(width.to_i) }
      it { expect(create.height).to eq(height.to_i) }
    end

    context 'with wrong number of arguments' do
      it { expect { described_class.create(width) }.to raise_error(BadNumberArguments) }
    end

    context 'with bad type of arguments' do
      it { expect { described_class.create(width, 'foo') }.to raise_error(InvalidArguments) }
      it { expect { described_class.create('foo', height) }.to raise_error(InvalidArguments) }
    end
  end
end
