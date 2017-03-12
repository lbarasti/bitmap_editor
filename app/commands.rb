require_relative 'bitmap'

class Command
  def initialize(fn)
    @fn = fn
  end
  # traverse the given coordinates and print information about any invalid value
  def valid?(*coordinates)
    coordinates.reduce(true) do |acc, (value, max)|
      (1..max).include?(value).tap do |is_valid|
        puts "Invalid input #{value}: the allowed range is (1, #{max})" unless is_valid
      end && acc
    end
  end
  # provide Proc-like interface
  def call bm; @fn.(bm); end
end

module Commands
  extend Bitmap

  Show = Command.new(method(:show))
  Clear = Command.new(method(:clear))
  class Init < Command
    def initialize(m, n, max_x, max_y)
      super(-> bm {
        return bm unless valid?([m, max_x], [n, max_y])
        init(m, n)
      })
    end
  end
  class Color < Command
    def initialize(x, y, c)
      super(-> bm {
        return bm unless valid?([x, size(bm).x], [y, size(bm).y])
        color(bm, x.to_i, y.to_i, c)
      })
    end
  end
  class Horizontal < Command
    def initialize(x1, x2, y, c)
      super(-> bm {
        return bm unless valid?([x1, size(bm).x], [x2, size(bm).x], [y, size(bm).y])
        row(bm, x1, x2, y, c)
      })
    end
  end
  class Vertical < Command
    def initialize(x, y1, y2, c)
      super(-> bm {
          return bm unless valid?([x, size(bm).x], [y1, size(bm).y], [y2, size(bm).y])
          col(bm, x, y1, y2, c)
        })
    end
  end
  Unknown = Command.new(-> bm {
    puts 'unrecognised command :('
    bm
  })
end