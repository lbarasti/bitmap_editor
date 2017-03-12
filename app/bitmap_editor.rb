require_relative 'bitmap'

# I M N: init M columns and N rows
# C: clear
# L X Y C
# V X Y1 Y2 C
# H X1 X2 V C
# S: Show
# https://gist.github.com/soulnafein/8ee4e60def4e5468df2f
# https://github.com/carwow/bitmap_editor/blob/master/app/bitmap_editor.rb
class BitmapEditor
  MAX_X = 250
  MAX_Y = 250
  def run(input_stream)
    puts "Running in interactive mode" unless input_stream.file.is_a? File

    input_stream.reduce(init(MAX_X, MAX_Y)) do |bm, line|
      case line.chomp
      when 'S'
        show(bm)
      when 'C'
        clear(bm)
      when /^I (\d+) (\d+)$/
        m, n = $1, $2
        init(m.to_i, n.to_i)
      when /^L (\d+) (\d+) ([A-Z])/
        x, y, c = $1, $2, $3
        color(bm, x.to_i, y.to_i, c)
      when /^H (\d+) (\d+) (\d+) ([A-Z])$/
        x1, x2, y, c = $1, $2, $3, $4
        row(bm, x1.to_i, x2.to_i, y.to_i, c)
      when /^V (\d+) (\d+) (\d+) ([A-Z])$/
        x, y1, y2, c = $1, $2, $3, $4
        col(bm, x.to_i, y1.to_i, y2.to_i, c)
      else
        puts 'unrecognised command :('
        bm
      end
    end
  end
end

trap "SIGINT" do
  puts "\rExiting interactive mode"
  exit 0
end