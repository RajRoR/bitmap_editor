require './lib/command'
require './lib/bitmap'
require './lib/utils'

module Commands
  # Create a new M x N image with all pixels colored white (O)
  class Create < Command
    attr_reader :width, :height

    # Initialize the Class.
    #
    # @param [Integer] width the width of the bitmap
    # @param [Integer] height the height of the bitmap
    def initialize(width, height)
      @width  = width.to_i
      @height = height.to_i
    end

    # Execute the command. Create the Bitmap object.
    # @param [App] app App object running the application.
    def execute(app)
      app.bitmap = Bitmap.new(width, height)
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method.
    #
    # @return [Create] the newly created instance of the command.
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 2) if args.length != 2
      raise InvalidArguments unless Utils.i?(args[0]) && Utils.i?(args[1])

      new(*args)
    end
  end
end
