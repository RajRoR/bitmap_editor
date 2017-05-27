require './lib/app'

class BitmapEditor
  def run(file)
    plot_bitmap(file)
  end

  private

  def plot_bitmap(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)

    app = App.new

    File.open(file).each do |line|
      line = line.chomp
      mapper = app.mapper
      mapper.map(line).execute
    end
  end

end
