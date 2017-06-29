require './lib/command'

module Commands
  # Color a Pixel with the provided color
  class ColorPixel < Command
    attr_reader :x, :y, :color

    # Initialize the Class.
    #
    # @param [Integer] x the x of the pixel
    # @param [Integer] y the y of the pixel
    # @param [Char] color the color to apply on (x, y) pixel.
    def initialize(x, y, color)
      @x = x.to_i
      @y = y.to_i
      @color = color
    end

    # Color the pixel (x, y)
    # @param [App] app App object
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?
      app.bitmap[x, y] = color
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method.
    # @return [ColorPixel] the newly created instance of the command.
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 3) if args.length != 3
      raise InvalidArguments unless Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.color?(args[2])

      new(*args)
    end
  end
end
