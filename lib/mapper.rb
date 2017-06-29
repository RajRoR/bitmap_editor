# Class Mapper
class Mapper
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
    public_send("command_#{cmd}", *args)
  end
end

require './lib/error'
Dir[File.join(File.expand_path('../', __FILE__), 'commands', '*')].each {|f| require f}