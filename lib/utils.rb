class Utils
  # Return if `str` is an Integer
  def self.is_i?(str)
    str.is_a?(Integer) ? true : /\A[-+]?\d+\z/ === str
  end

  # Return is `str` is a color
  def self.is_color?(str)
    str.size == 1 && str[0] >= 'A' && str[0] <= 'Z'
  end
end