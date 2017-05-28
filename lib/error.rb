# Class Error inheriting StandardError class
class Error < StandardError; end

# Class OutOfRange to raise the exception when the provided pixel is out of range
class OutOfRange < Error
  def initialize(msg = 'The provided pixels are out of range.')
    super
  end
end

# Class InvalidCommand to raise the exception for invalid command provided
class InvalidCommand < Error
  def initialize(cmd)
    super("The command '#{cmd}' does not exist.")
  end
end

# Class InvalidArguments to raise the exception for invalid arguments provided
class InvalidArguments < Error
  def initialize(msg = 'The provided command does not have the correct arguments.')
    super
  end
end

# Class MissingBitmap to raise the exception when no bitmap exists
class MissingBitmap < Error
  def initialize(msg = 'Bitmap is Missing!')
    super
  end
end

# Class BadNumberArguments to raise the exception for wrong number of arguments provided
class BadNumberArguments < Error
  def initialize(given, expected)
    super("Wrong number of arguments (#{given} given, #{expected} expected).")
  end
end
