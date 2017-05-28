require 'spec_helper'

describe Utils do
  describe '#is_i?' do
    it { expect(Utils.is_i?('2')).to eq(true) }
    it { expect(Utils.is_i?('foo')).to eq(false) }
  end

  describe '#is_color?' do
    it { expect(Utils.is_color?('B')).to eq(true) }
    it { expect(Utils.is_color?('b')).to eq(false) }
    it { expect(Utils.is_color?('foo')).to eq(false) }
  end
end
