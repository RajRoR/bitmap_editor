require './lib/command'

module Commands
  # Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)
  class VerticalDraw < Command
    attr_reader :x, :y1, :y2, :color

    # Initialize the Class.
    #
    # @param [App] app App object
    # @param [Integer] x the column to modify
    # @param [Integer] y1 the row beginning coordinate
    # @param [Integer] y2 the row ending coordinate
    # @param [Char] color the colour to apply on the column.
    def initialize(app, x, y1, y2, color)
      super(app)
      @x = x.to_i
      @y1 = y1.to_i
      @y2 = y2.to_i
      @color = color
    end

    # Draw a vertical segment with color C in column X between rows Y1 and Y2 (inclusive)
    def execute
      raise MissingBitmap if app.bitmap.nil?

      (y1..y2).each do |y|
        color_pixel = Commands::ColorPixel.create(app, x, y, color)
        color_pixel.execute
      end
    end

    # Class method. Verify the arguments and create the command
    #
    # @param [App] app App object
    # @param [] args List of the arguments passed to the initialize method
    # @return [VerticalDraw] the newly created instance of the command
    def self.create(app, *args)
      raise BadNumberArguments.new(args.length, 4) if args.length != 4
      raise InvalidArguments unless valid_args?(args)

      new(app, *args)
    end

    class << self
      private

      def valid_args?(args)
        Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.i?(args[2]) && Utils.color?(args[3])
      end
    end
  end
end
