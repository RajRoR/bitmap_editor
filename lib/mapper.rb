require './lib/commands/clear'
require './lib/commands/create'
require './lib/commands/color_pixel'
require './lib/commands/vertical_draw'
require './lib/commands/horizontal_draw'
require './lib/commands/fill_region'
require './lib/commands/outline'
require './lib/commands/show'
require './lib/error'

# Class Mapper
#
# Created on
class Mapper
  attr_reader :app

  # Initialize the class.
  def initialize(app)
    @app = app
  end

  def self.commands
    {
      'I' => 'Create',
      'C' => 'Clear',
      'L' => 'ColorPixel',
      'V' => 'VerticalDraw',
      'H' => 'HorizontalDraw',
      'F' => 'FillRegion',
      'O' => 'Outline',
      'S' => 'Show'
    }
  end

  Mapper.commands.each do |c, v|
    define_method("command_#{c}") do |*args|
      Commands.const_get(v.to_s).create(*args)
    end
  end

  def map(str)
    args = str.split
    cmd = args.shift
    raise InvalidCommand, cmd unless Mapper.commands.key?(cmd)
    public_send("command_#{cmd}", app, *args)
  end
end
