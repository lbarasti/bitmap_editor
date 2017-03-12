module Bitmap
  Size = Struct.new :x, :y

  def init m, n
    (1..n).map{ (1..m).map{ ?O } }
  end

  def clear bitmap
    rows = bitmap.size
    cols = bitmap[0].size
    init cols, rows
  end

  def to_string bitmap
    bitmap.map(&:join).join("\n")
  end

  def show bitmap
    puts to_string(bitmap)
    bitmap
  end

  def color bitmap, x, y, c
    row bitmap, x, x, y, c
  end

  def row bitmap, x1, x2, y, c
    range = (x1 - 1..x2 - 1)
    bitmap.map.with_index{|row, i| i == (y - 1) ?
      row.map.with_index{|v, j| range.include?(j) ? c : v} : row}
  end

  def col bitmap, x, y1, y2, c
    transpose(row(transpose(bitmap), y1, y2, x, c))
  end

  def transpose bitmap
    rows = bitmap.size
    cols = bitmap[0].size
    (0...cols).map{|i| (0...rows).map{|j| bitmap[j][i]}}
  end

  def size bitmap
    rows = bitmap.size
    cols = bitmap[0].size
    Size.new(cols, rows)
  end
end