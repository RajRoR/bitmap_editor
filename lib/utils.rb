# Class Utils - To accommodate miscellaneous methods
class Utils
  class << self
    # Return if `str` is an Integer
    def i?(str)
      str.is_a?(Integer) ? true : !(/\A[-+]?\d+\z/ =~ str).nil?
    end

    # Return is `str` is a color
    def color?(str)
      str.size == 1 && str[0] >= 'A' && str[0] <= 'Z'
    end
  end
end
