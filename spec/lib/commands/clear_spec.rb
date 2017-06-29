require 'spec_helper'

describe Commands::Clear do
  let(:app) { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(2, 2).execute(app)
    end

    subject(:command_clear) { described_class.new }

    describe '#execute' do
      before do
        app.bitmap[1, 1] = 'A'
      end

      it { expect { command_clear.execute(app) }.to change { app.bitmap.data }.from('AOOO').to('OOOO') }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:clear_create) { described_class.create }

        it { expect(clear_create).to be_a(described_class) }
      end

      context 'with wrong number of arguments' do
        it { expect { described_class.create(app, 'foo') }.to raise_error(BadNumberArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:clear_new) { described_class.new }

    describe '#execute' do
      it { expect { clear_new.execute(app) }.to raise_error(MissingBitmap) }
    end
  end
end
