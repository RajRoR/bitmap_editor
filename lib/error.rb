class Error < StandardError; end

class OutOfRange < Error
  def initialize(msg = 'The provided pixels are out of range.')
    super
  end
end

class InvalidCommand < Error
  def initialize(cmd)
    super("The command '#{cmd}' does not exist.")
  end
end

class InvalidArguments < Error
  def initialize(msg = 'The provided command does not have the correct arguments.')
    super
  end
end

class MissingBitmap < Error
  def initialize(msg = 'Bitmap is Missing!')
    super
  end
end

class BadNumberArguments < Error
  def initialize(given, expected)
    super("Wrong number of arguments (#{given} given, #{expected} expected).")
  end
end
