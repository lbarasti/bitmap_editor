require_relative 'bitmap'
include Bitmap
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

  def valid?(*coordinates)
    coordinates.reduce(true) do |acc, (value, max)|
      (1..max).include?(value).tap do |is_valid|
        puts "Invalid input #{value}: the allowed range is (1, #{max})" unless is_valid
      end && acc
    end
  end

  def run(input_stream)
    puts "Running in interactive mode" unless input_stream.file.is_a? File

    initial_bitmap = init(MAX_X, MAX_Y)
    input_stream.reduce(initial_bitmap) do |bm, line|
      case line.chomp
      when 'S' then show(bm)
      when 'C' then clear(bm)
      when /^I (\d+) (\d+)$/
        m, n = $1.to_i, $2.to_i
        next bm unless valid?([m, MAX_X], [n, MAX_Y])
        init(m, n)
      when /^L (\d+) (\d+) ([A-Z])$/
        x, y, c = $1.to_i, $2.to_i, $3
        next bm unless valid?([x, size(bm).x], [y, size(bm).y])
        color(bm, x.to_i, y.to_i, c)
      when /^H (\d+) (\d+) (\d+) ([A-Z])$/
        x1, x2, y, c = $1.to_i, $2.to_i, $3.to_i, $4
        next bm unless valid?([x1, size(bm).x], [x2, size(bm).x], [y, size(bm).y])
        row(bm, x1, x2, y, c)
      when /^V (\d+) (\d+) (\d+) ([A-Z])$/
        x, y1, y2, c = $1.to_i, $2.to_i, $3.to_i, $4
        next bm unless valid?([x, size(bm).x], [y1, size(bm).y], [y2, size(bm).y])
        col(bm, x, y1, y2, c)
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