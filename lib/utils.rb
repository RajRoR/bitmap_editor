# Class Utils - To accommodate miscellaneous methods
class Utils
  # Return if `str` is an Integer
  def self.i?(str)
    str.is_a?(Integer) ? true : !(/\A[-+]?\d+\z/ =~ str).nil?
  end

  # Return is `str` is a color
  def self.color?(str)
    str.size == 1 && str[0] >= 'A' && str[0] <= 'Z'
  end
end
