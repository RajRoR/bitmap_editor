require 'spec_helper'

describe Utils do
  describe '#is_i?' do
    it { expect(described_class.is_i?('2')).to eq(true) }
    it { expect(described_class.is_i?('foo')).to eq(false) }
  end

  describe '#is_color?' do
    it { expect(described_class.is_color?('B')).to eq(true) }
    it { expect(described_class.is_color?('b')).to eq(false) }
    it { expect(described_class.is_color?('foo')).to eq(false) }
  end
end
