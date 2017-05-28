require 'spec_helper'

describe Commands::Clear do
  let(:app) { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject { Commands::Clear.new(app) }

    describe '#initialize' do
      it { expect(subject.app).to eq(app) }
    end

    describe '#execute' do
      before do
        app.bitmap[1, 1] = 'A'
      end

      it { expect { subject.execute }.to change { app.bitmap.data }.from('AOOO').to('OOOO') }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject { Commands::Clear.create(app) }

        it { expect(subject).to be_a(Commands::Clear) }
      end

      context 'with wrong number of arguments' do
        it { expect { Commands::Clear.create(app, 'foo') }.to raise_error(BadNumberArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject { Commands::Clear.new(app) }

    describe '#execute' do
      it { expect { subject.execute }.to raise_error(MissingBitmap) }
    end
  end
end
