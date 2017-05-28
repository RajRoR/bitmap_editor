require 'spec_helper'

describe Utils do
  describe '#i?' do
    it { expect(described_class.i?('2')).to eq(true) }
    it { expect(described_class.i?('foo')).to eq(false) }
  end

  describe '#color?' do
    it { expect(described_class.color?('B')).to eq(true) }
    it { expect(described_class.color?('b')).to eq(false) }
    it { expect(described_class.color?('foo')).to eq(false) }
  end
end
