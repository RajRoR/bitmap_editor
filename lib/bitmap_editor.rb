require './lib/app'
require './lib/mapper'

class BitmapEditor
  attr_reader :file

  # Initialize the class.
  def initialize(file)
    @file = file
  end

  def run
    plot_bitmap(file)
  end

  private

  def plot_bitmap(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)

    app = App.new

    File.open(file).each do |line|
      line = line.chomp
      mapper = app.mapper
      mapper.map(line).execute
    end
  end

end
