require 'spec_helper'

describe App do
  subject { App.new }

  describe '#initialize' do
    it { expect(subject.bitmap).to eq(nil) }
    it { expect(subject.mapper).to be_a(Mapper) }
  end
end
