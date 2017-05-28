require 'spec_helper'

describe Commands::Show do
  let(:app) { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject(:show_new) { described_class.new(app) }

    describe '#initialize' do
      it { expect(show_new.app).to eq(app) }
    end

    describe '#execute' do
      it { expect { show_new.execute }.to output("OO\nOO\n").to_stdout }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:show_create) { described_class.create(app) }

        it { expect(show_create).to be_a(described_class) }
      end

      context 'with bad number of arguments' do
        it { expect { described_class.create(app, 'foo') }.to raise_error(BadNumberArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:show_new) { described_class.new(app) }

    describe '#execute' do
      it { expect { show_new.execute }.to raise_error(MissingBitmap) }
    end
  end
end
