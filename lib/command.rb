# Base class for all the `Commands` classes
class Command
  # Should be implemented by the child class.
  def execute
    raise NotImplementedMethod
  end
end
