require 'spec_helper'

describe Commands::Show do
  let(:app) { App.new }

  context "when a bitmap is already created" do

    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject { Commands::Show.new(app) }

    describe ".initialize" do

      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect { subject.execute }.to output("OO\nOO\n").to_stdout }

    end

    describe ".create" do

      context "when correct arguments" do

        subject { Commands::Show.create(app) }

        it { expect(subject).to be_a(Commands::Show) }

      end

      context "when bad number of arguments" do

        it { expect { Commands::Show.create(app, "foo") }.to raise_error(BadNumberArguments) }

      end

    end

  end

  context "when no bitmap created" do

    subject { Commands::Show.new(app) }

    describe ".initialize" do

      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect{ subject.execute }.to raise_error(MissingBitmap) }

    end

  end

end