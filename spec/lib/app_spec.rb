require 'spec_helper'

describe App do
  subject(:app) { described_class.new }

  describe '#initialize' do
    it { expect(app.bitmap).to eq(nil) }
    it { expect(app.mapper).to be_a(Mapper) }
  end
end
