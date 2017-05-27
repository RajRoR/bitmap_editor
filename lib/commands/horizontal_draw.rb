require './lib/command'

module Commands
  class HorizontalDraw < Command
    attr_reader :x1, :x2, :y, :color

    # Initialize the Class.
    #
    # @param [App] app App object
    # @param [Integer] x1 the column beginning coordinates.
    # @param [Integer] x2 the column ending coordinates.
    # @param [Integer] y the row to modify.
    # @param [Char] color the color to apply on the column.
    def initialize(app, x1, x2, y, color)
      super(app)
      @x1 = x1.to_i
      @x2 = x2.to_i
      @y = y.to_i
      @color = color
    end

    # Draw the pixels with color `color` in row Y between columns X1 and X2 (inclusive).
    def execute
      fail MissingBitmap if app.bitmap.nil?

      (x1..x2).each do |x|
        color_pixel = Commands::ColorPixel.create(app, x, y, color)
        color_pixel.execute
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object
    # @param [] args List of the arguments passed to the initialize method
    # @return [HorizontalDraw] the newly created instance of the command
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 4) if args.length != 4
      fail InvalidArguments unless Utils.is_i?(args[0]) && Utils.is_i?(args[1]) &&
        Utils.is_i?(args[2]) && Utils.is_color?(args[3])

      new(app, *args)
    end
  end
end