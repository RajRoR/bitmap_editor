# Base class for all the `Commands` classes
class Command
  attr_reader   :app
  attr_accessor :saved_img

  # Initialize Command Class.
  def initialize(app)
    @app = app
    @saved_img = nil
  end

  # Should be implemented by the child class.
  def execute
    fail NotImplementedMethod
  end
end