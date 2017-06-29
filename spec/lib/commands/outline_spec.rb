require 'spec_helper'

describe Commands::Outline do
  let(:app) {App.new}
  let(:x1) {'1'}
  let(:y1) {'1'}
  let(:x2) {'4'}
  let(:y2) {'4'}
  let(:color) {'X'}

  context 'when a bitmap is already created' do
    before do
      Commands::Create.new(app, 4, 4).execute
    end

    subject(:outline_new) {described_class.new(app, x1, y1, x2, y2, color)}

    describe '#initialize' do
      it {expect(outline_new.app).to eq(app)}
      it {expect(outline_new.x1).to eq(x1.to_i)}
      it {expect(outline_new.y1).to eq(y1.to_i)}
      it {expect(outline_new.x2).to eq(x2.to_i)}
      it {expect(outline_new.y2).to eq(y2.to_i)}
      it {expect(outline_new.color).to eq(color)}
    end

    describe '#execute' do
      context "color pixels" do
        before {outline_new.execute}

        it {expect(app.bitmap[x1.to_i, y1.to_i]).to eq(color)}
        it {expect(app.bitmap[x2.to_i, y2.to_i]).to eq(color)}
      end

      context "final result" do
        it {expect { outline_new.execute }.to change {app.bitmap.data}.from('OOOOOOOOOOOOOOOO').to('XXXXXOOXXOOXXXXX')}
      end
    end

    describe '#create' do
      context 'with correct arguments' do
        subject(:outline_create) {described_class.create(app, x1, y1, x2, y2, color)}

        it {expect(outline_create).to be_a(described_class)}
        it {expect(outline_create.x1).to eq(x1.to_i)}
        it {expect(outline_create.y1).to eq(y1.to_i)}
        it {expect(outline_create.x2).to eq(x2.to_i)}
        it {expect(outline_create.y2).to eq(y2.to_i)}
        it {expect(outline_create.color).to eq(color)}
      end

      context 'with wrong number of arguments' do
        it {expect {described_class.create(app, x1, y2)}.to raise_error(BadNumberArguments)}
      end

      context 'with bad type of arguments' do
        it {expect {described_class.create(app, 'foo', y1, x2, y2, color)}.to raise_error(InvalidArguments)}
        it {expect {described_class.create(app, x1, 'foo', x2, y2, color)}.to raise_error(InvalidArguments)}
        it {expect {described_class.create(app, x1, y1, 'foo', y2, color)}.to raise_error(InvalidArguments)}
        it {expect {described_class.create(app, x1, y1, x2, 'foo', color)}.to raise_error(InvalidArguments)}
        it {expect {described_class.create(app, x1, y1, x2, y2, 'foo')}.to raise_error(InvalidArguments)}
      end
    end
  end

  context 'when no bitmap was created' do
    subject(:outline_new) {described_class.new(app, x1, y1, x2, y2, color)}

    describe '#execute' do
      it {expect {outline_new.execute}.to raise_error(MissingBitmap)}
    end
  end
end
