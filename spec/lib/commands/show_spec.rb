require 'spec_helper'

describe Commands::Show do
  let(:app) { App.new }

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(2, 2).execute(app)
    end

    subject(:show_new) { described_class.new }

    describe '#execute' do
      it { expect { show_new.execute(app) }.to output("OO\nOO\n").to_stdout }
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:show_create) { described_class.create }

        it { expect(show_create).to be_a(described_class) }
      end

      context 'with bad number of arguments' do
        it { expect { described_class.create('foo') }.to raise_error(BadNumberArguments) }
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:show_new) { described_class.new }

    describe '#execute' do
      it { expect { show_new.execute(app) }.to raise_error(MissingBitmap) }
    end
  end
end
