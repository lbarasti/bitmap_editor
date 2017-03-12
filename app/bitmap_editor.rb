require_relative 'bitmap'
require_relative 'commands'
include Bitmap

class BitmapEditor
  MAX_X = 250
  MAX_Y = 250

  def run(input_stream)
    initial_bitmap = Bitmap.init(MAX_X, MAX_Y)
    input_stream.reduce(initial_bitmap) do |bm, line|
      parse(line.chomp).call(bm)
    end
  end

  def parse(cmd)
    case cmd
    when 'S' then Commands::Show
    when 'C' then Commands::Clear
    when /^I (\d+) (\d+)$/
      m, n = $1.to_i, $2.to_i
      Commands::Init.new(m, n, MAX_X, MAX_Y)
    when /^L (\d+) (\d+) ([A-Z])$/
      x, y, c = $1.to_i, $2.to_i, $3
      Commands::Color.new(x, y, c)
    when /^H (\d+) (\d+) (\d+) ([A-Z])$/
      x1, x2, y, c = $1.to_i, $2.to_i, $3.to_i, $4
      Commands::Horizontal.new(x1, x2, y, c)
    when /^V (\d+) (\d+) (\d+) ([A-Z])$/
      x, y1, y2, c = $1.to_i, $2.to_i, $3.to_i, $4
      Commands::Vertical.new(x, y1, y2, c)
    else
      Commands::Unknown
    end
  end
end
