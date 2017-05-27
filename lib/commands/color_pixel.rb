require './lib/command'

module Commands
  class ColorPixel < Command
    attr_reader :x, :y, :color

    # Initialize the Class.
    #
    # @param [App] app App object
    # @param [Integer] x the x of the pixel
    # @param [Integer] y the y of the pixel
    # @param [Char] color the color to apply on (x, y) pixel.
    def initialize(app, x, y, color)
      super(app)
      @x = x.to_i
      @y = y.to_i
      @color = color
    end

    # Color the pixel (x, y)
    def execute
      fail MissingBitmap if app.bitmap.nil?
      # @saved_data = app.bitmap[x, y]
      app.bitmap[x, y] = color
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object
    # @param [] args List of the arguments passed to the initialize method.
    # @return [ColorPixel] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 3) if args.length != 3
      fail InvalidArguments unless Utils.is_i?(args[0]) && Utils.is_i?(args[1]) && Utils.is_color?(args[2])
      new(app, *args)
    end
  end
end