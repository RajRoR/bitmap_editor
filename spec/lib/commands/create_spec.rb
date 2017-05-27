require 'spec_helper'

describe Commands::Create do
  let(:app)    { App.new }
  let(:width)  { "2" }
  let(:height) { "2" }

  subject { Commands::Create.new(app, width, height) }

  describe "#initialize" do
    it { expect(subject.app).to eq(app) }
    it { expect(subject.width).to eq(width.to_i) }
    it { expect(subject.height).to eq(height.to_i) }
  end

  describe "#execute" do
    before { subject.execute }

    it { expect(app.bitmap).to be_a(Bitmap) }
    it { expect(app.bitmap.width).to eq(width.to_i) }
    it { expect(app.bitmap.height).to eq(height.to_i) }
  end

  describe "#create" do
    context "with correct arguments" do
      subject { Commands::Create.create(app, width, height) }

      it { expect(subject).to be_a(Commands::Create) }
      it { expect(subject.width).to eq(width.to_i) }
      it { expect(subject.height).to eq(height.to_i) }
    end

    context "with wrong number of arguments" do
      it {expect { Commands::Create.create(app, width) }.to raise_error(BadNumberArguments) }
    end

    context "with bad type of arguments" do
      it { expect { Commands::Create.create(app, width, "foo") }.to raise_error(InvalidArguments) }
      it { expect { Commands::Create.create(app, "foo", height) }.to raise_error(InvalidArguments) }
    end
  end
end