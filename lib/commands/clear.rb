require './lib/command'

module Commands
  # Clears the table, setting all pixels to white (O)
  class Clear < Command
    # Clear the bitmap
    def execute(app)
      raise MissingBitmap if app.bitmap.nil?

      app.bitmap.clear
    end

    # Class method. Verify the arguments and create the command
    #
    # @param [App] app App object
    # @param [] args List of the arguments passed to the initialize method
    # @return [Clear] the newly created instance of the command
    def self.create(*args)
      raise BadNumberArguments.new(args.length, 0) unless args.empty?

      new()
    end
  end
end
