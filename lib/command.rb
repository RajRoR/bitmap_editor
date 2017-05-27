# Base class for all the `Commands` classes
class Command
  attr_reader :app

  # Initialize Command Class.
  def initialize(app)
    @app = app
  end

  # Should be implemented by the child class.
  def execute
    raise NotImplementedMethod
  end
end
