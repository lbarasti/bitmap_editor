require_relative 'bitmap'

module Commands
  extend Bitmap

  Show = method(:show)
  Clear = method(:clear)
  Init = -> (m, n, max_x, max_y) {
    -> bm {
      return bm unless valid?([m, max_x], [n, max_y])
      init(m, n)
    }
  }
  Color = -> (x, y, c) {
    -> bm {
      return bm unless valid?([x, size(bm).x], [y, size(bm).y])
      color(bm, x.to_i, y.to_i, c)
    }
  }
  Horizontal = -> (x1, x2, y, c) {
    -> bm {
      return bm unless valid?([x1, size(bm).x], [x2, size(bm).x], [y, size(bm).y])
      row(bm, x1, x2, y, c)
    }
  }
  Vertical = -> (x, y1, y2, c) {
    -> bm {
      return bm unless valid?([x, size(bm).x], [y1, size(bm).y], [y2, size(bm).y])
      col(bm, x, y1, y2, c)
    }
  }
  Unknown = -> {
    puts 'unrecognised command :('
    bm
  }

  def self.valid?(*coordinates)
    coordinates.reduce(true) do |acc, (value, max)|
      (1..max).include?(value).tap do |is_valid|
        puts "Invalid input #{value}: the allowed range is (1, #{max})" unless is_valid
      end && acc
    end
  end
end