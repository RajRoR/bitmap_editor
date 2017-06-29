require './lib/command'

module Commands
  # Draw an outline with the given points and color
  class Outline < Command
    attr_reader :app, :x1, :y1, :x2, :y2, :color

    # Initialize the Class.
    #
    # @param [Integer] x1 the column to modify
    # @param [Integer] y1 the row beginning coordinate
    # @param [Integer] x2 the column to modify
    # @param [Integer] y2 the row ending coordinate
    # @param [Char] color the colour to apply on the column.
    def initialize(x1, y1, x2, y2, color)
      @x1 = x1.to_i
      @y1 = y1.to_i
      @x2 = x2.to_i
      @y2 = y2.to_i
      @color = color
    end

    # Color the outline (x1, y1), (x2, y2)
    # @param [App] app App object
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?

      [x1, x2].each do |x|
        vdraw = Commands::VerticalDraw.create(x, y1, y2, color)
        vdraw.execute(app)
      end

      [y1, y2].each do |y|
        hdraw = Commands::HorizontalDraw.create(x1, x2, y, color)
        hdraw.execute(app)
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Outline] the newly created instance of the command.
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 5) if args.length != 5
      raise InvalidArguments unless valid_args?(args)

      new(*args)
    end

    class << self
      private

      def valid_args?(args)
        Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.i?(args[2]) && Utils.i?(args[3]) && Utils.color?(args[4])
      end
    end
  end
end