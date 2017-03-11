require_relative 'commands'

# I M N: init M columns and N rows
# C: clear
# L X Y C
# V X Y1 Y2 C
# H X1 X2 V C
# S: Show
# https://gist.github.com/soulnafein/8ee4e60def4e5468df2f
# https://github.com/carwow/bitmap_editor/blob/master/app/bitmap_editor.rb
class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).reduce(nil) do |bm, line|
      line = line.chomp
      case line
      when 'S'
        bm.nil? ? (puts "There is no image") : show(bm)
      when 'C'
        bm.nil? ? (puts "There is no image") : clear(bm)
      when /^I \d\d?\d? \d\d?\d?$/
        _, m, n = line.split(' ')
        init(m.to_i, n.to_i)
      when /^L \d\d?\d? \d\d?\d? [A-Z]/
        _, x, y, c = line.split(' ')
        color(bm, x.to_i, y.to_i, c)
      when /^H \d\d?\d? \d\d?\d? \d\d?\d? [A-Z]$/
        _, x1, x2, y, c = line.split(' ')
        row(bm, x1.to_i, x2.to_i, y.to_i, c)
      when /^V \d\d?\d? \d\d?\d? \d\d?\d? [A-Z]$/
        _, x, y1, y2, c = line.split(' ')
        col(bm, x.to_i, y1.to_i, y2.to_i, c)
      else
        puts 'unrecognised command :('
      end
    end
  end
end
