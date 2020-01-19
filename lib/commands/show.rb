module Commands
  # Show the contents of the current image
  class Show < Command
    # Display the bitmap.
    # @param [App] app App object running the application.
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?

      width = app.bitmap.width
      height = app.bitmap.height
      (1..height).each do |y|
        (1..width).each do |x|
          print app.bitmap[x, y]
        end
        puts
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Show] the newly created instance of the command.
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 0) unless args.empty?

      new
    end
  end
end
