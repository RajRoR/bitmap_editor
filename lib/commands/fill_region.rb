require './lib/command'

module Commands
  # Fill the region in which pixel (X, Y) lies, with Color C
  class FillRegion < Command
    attr_reader :x, :y, :color

    # Initialize the Class
    #
    # @param [Integer] x the column in the region
    # @param [Integer] y the row in the region
    # @param [Char] color the color to apply in the region
    def initialize(x, y, color)
      @x = x.to_i
      @y = y.to_i
      @color = color
    end

    # Fill the region in which pixel (X, Y) lies, with Color C
    # @param [App] app App object
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?
      @app = app
      fill(app.bitmap, x, y, app.bitmap[x, y], color)
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Fill] the newly created instance of the command.
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 3) if args.length != 3
      raise InvalidArguments unless valid_args?(args)

      new(*args)
    end

    private

    # Fill the region pixel by pixel, recursively
    #
    # @param [Bitmap] bitmap Bitmap object
    # @param [Integer] x the column to modify
    # @param [Integer] y the row to modify
    # @param [Char] existing_color the existing color of the the pixel
    # @param [Char] new_color the color to fill for the pixel
    def fill(bitmap, x, y, existing_color, new_color)
      return unless bitmap.check_range(x, y) && bitmap[x, y] == existing_color

      color_pixel(x, y, new_color)
      fill(bitmap, (x + 1), y, existing_color, new_color)
      fill(bitmap, (x - 1), y, existing_color, new_color)
      fill(bitmap, x, (y + 1), existing_color, new_color)
      fill(bitmap, x, (y - 1), existing_color, new_color)
    end

    def color_pixel(x, y, color)
      color_pixel = Commands::ColorPixel.create(x, y, color)
      color_pixel.execute(@app)
    end

    class << self
      def valid_args?(args)
        Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.color?(args[2])
      end
    end
  end
end
