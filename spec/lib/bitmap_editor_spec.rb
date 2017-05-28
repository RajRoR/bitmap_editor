require 'spec_helper'

describe BitmapEditor do
  subject(:bitmap_editor) { described_class.new }

  let(:file) { './spec/factories/basic.txt' }

  describe '#run' do
    it 'should make a call to `plot_bitmap` with file path' do
      expect(bitmap_editor).to receive(:plot_bitmap).with(file)
      bitmap_editor.run(file)
    end
  end
end
