require 'spec_helper'

describe Commands::Clear do
  let(:app) { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject(:command_clear) { described_class.new(app) }

    describe '#initialize' do
      it { expect(command_clear.app).to eq(app) }
    end

    describe '#execute' do
      before do
        app.bitmap[1, 1] = 'A'
      end

      it { expect { command_clear.execute }.to change { app.bitmap.data }.from('AOOO').to('OOOO') }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:clear_create) { described_class.create(app) }

        it { expect(clear_create).to be_a(described_class) }
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(app, 'foo') }.to raise_error(BadNumberArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:clear_new) { described_class.new(app) }

    describe '#execute' do
      it { expect { clear_new.execute }.to raise_error(MissingBitmap) }
    end
  end
end
