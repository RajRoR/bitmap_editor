require './lib/mapper'

#  Class App - To handle the running application
class App
  attr_reader   :mapper
  attr_accessor :bitmap

  # Initialize the class.
  def initialize
    @bitmap = nil
    @mapper = Mapper.new(self)
  end
end
