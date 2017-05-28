require './lib/command'

module Commands
  class Clear < Command
    # Clear the bitmap
    def execute
      raise MissingBitmap if app.bitmap.nil?

      app.bitmap.clear
    end

    # Class method. Verify the arguments and create the command
    #
    # @param [App] app App object
    # @param [] args List of the arguments passed to the initialize method
    # @return [Clear] the newly created instance of the command
    def self.create(app, *args)
      raise BadNumberArguments.new(args.length, 0) unless args.empty?

      new(app)
    end
  end
end
