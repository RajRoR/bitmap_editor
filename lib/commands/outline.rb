require './lib/command'

module Commands
  class Outline < Command
    attr_reader :app, :x1, :y1, :x2, :y2, :color

    def initialize(app, x1, y1, x2, y2, color)
      super(app)
      @x1 = x1.to_i
      @y1 = y1.to_i
      @x2 = x2.to_i
      @y2 = y2.to_i
      @color = color
    end

    def execute
      raise MissingBitmap if app.bitmap.nil?

      [x1, x2].each do |x|
        vdraw = Commands::VerticalDraw.create(app, x, y1, y2, color)
        vdraw.execute
      end

      [y1, y2].each do |y|
        hdraw = Commands::HorizontalDraw.create(app, x1, x2, y, color)
        hdraw.execute
      end
    end

    def self.create(app, *args)
      raise BadNumberArguments.new(args.length, 5) if args.length != 5
      raise InvalidArguments unless valid_args?(args)

      new(app, *args)
    end

    class << self
      private

      def valid_args?(args)
        Utils.i?(args[0]) && Utils.i?(args[1]) && Utils.i?(args[2]) && Utils.i?(args[3]) && Utils.color?(args[4])
      end
    end
  end
end