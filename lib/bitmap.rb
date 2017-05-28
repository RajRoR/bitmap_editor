# Class holding all basic bitmap methods
class Bitmap
  attr_reader :width, :height

  MAX_HEIGHT = MAX_WIDTH = 250

  # Initialize the class.
  #
  # @param [Integer] height the height of the bitmap
  # @param [Integer] width the width of the bitmap
  def initialize(width, height)
    @height = height.to_i
    @width = width.to_i
    clear
  end

  # Return the size of the data for the bitmap.
  #
  # @return [Integer] the size of the data representing the bitmap.
  def size
    raise OutOfRange if width > MAX_WIDTH || height > MAX_HEIGHT
    width * height
  end

  # Set and return the data if not done yet.
  #
  # @return [String] the data representing the bitmap.
  def data
    @data ||= 'O' * size
  end

  # Clear the bitmap by setting all the pixels to O.
  #
  # @return [String] the data representing the bitmap all with O.
  def clear
    @data = 'O' * size
  end

  # Element reference operator to get a pixel.
  #
  # @param [Integer] x the x of the pixel
  # @param [Integer] y the y of the pixel
  # @return [Char] the color of the pixel
  def [](x, y)
    raise OutOfRange unless check_range(x, y)
    data[index(x, y)]
  end

  # Return the real index in the table given the x and y position.
  #
  # @param [Integer] x the x of the pixel.
  # @param [Integer] y the y of the pixel.
  # @return [Integer] the real index in the table.
  def index(x, y)
    (y - 1) * width + (x - 1)
  end

  # Check if the pixel (x, y) is within the bitmap.
  #
  # @param [Integer] x the x of the pixel
  # @param [Integer] y the y of the pixel
  # @return [Boolean] true if the pixel is within the image.
  def check_range(x, y)
    !(x < 1 || y < 1 || x > width || y > height)
  end

  # Set a pixel with the given color.
  #
  # @param [Integer] x the x of the pixel
  # @param [Integer] y the y of the pixel
  # @param [Char] the new color of the pixel
  def []=(x, y, color)
    raise OutOfRange unless check_range(x, y)
    data[index(x, y)] = color
  end
end
