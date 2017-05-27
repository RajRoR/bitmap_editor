module Commands
  class Show < Command
    # Display the bitmap.
    def execute
      fail MissingBitmap if app.bitmap.nil?

      width = @app.bitmap.width
      height = @app.bitmap.height
      (1..height).each do |y|
        (1..width).each do |x|
          print @app.bitmap[x, y]
        end
        puts
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Show] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 0) unless args.empty?
      new(app)
    end
  end
end