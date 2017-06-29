require './lib/command'

module Commands
  # Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)
  class HorizontalDraw < Command
    attr_reader :x1, :x2, :y, :color

    # Initialize the Class.
    #
    # @param [Integer] x1 the column beginning coordinates.
    # @param [Integer] x2 the column ending coordinates.
    # @param [Integer] y the row to modify.
    # @param [Char] color the color to apply on the column.
    def initialize(x1, x2, y, color)
      @x1 = x1.to_i
      @x2 = x2.to_i
      @y = y.to_i
      @color = color
    end

    # Draw the pixels with color `color` in row Y between columns X1 and X2 (inclusive).
    # @param [App] app App object
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?

      (x1..x2).each do |x|
        color_pixel = Commands::ColorPixel.create(x, y, color)
        color_pixel.execute(app)
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method
    # @return [HorizontalDraw] the newly created instance of the command
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 4) if args.length != 4
      raise InvalidArguments unless valid_args?(args)

      new(*args)
    end

    class << self
      private

      def valid_args?(args)
        Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.i?(args[2]) && Utils.color?(args[3])
      end
    end
  end
end
