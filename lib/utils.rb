class Utils
  # Return if str is an Integer
  def self.is_i?(str)
    /\A[-+]?\d+\z/ === str
  end
end