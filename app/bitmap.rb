module Bitmap
  Size = Struct.new :x, :y

  def init m, n
    (1..n).map{ (1..m).map{ ?O } }
  end

  def clear bitmap
    sz = size(bitmap)
    init sz.x, sz.y
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

  def color_adj bitmap, x, y, target_color, source_color = bitmap[y-1][x-1], visited = []
    adj(x - 1, y - 1, bitmap, source_color, visited)
      .reduce([visited, bitmap]) do |(vis, bm), (i,j)|
        [vis.concat([i,j]), color(bm, i + 1, j + 1, target_color)]
      end
  end

  def color_all bitmap, x, y, target_color, source_color = bitmap[y-1][x-1], visited = []
    visited, bitmap = adj(x,y, bitmap, source_color, visited).reduce([visited,bitmap]){|(vis,bm), (i,j)|
      color_adj(bm, i, j, target_color, source_color, vis)
    }
  end
  
  def adj x, y, bitmap, color, visited
    (-1..1).flat_map{|i| (-1..1).map{|j| [x+i, y+j]}}
      .reject{|(i,j)| i < 0 || j < 0}
      .reject{|coord| visited.include? coord}
      .select{|(i,j)| bitmap[j][i] == color}
  end

  def transpose bitmap
    sz = size(bitmap)
    (0...sz.x).map{|i| (0...sz.y).map{|j| bitmap[j][i]}}
  end

  def size bitmap
    rows = bitmap.size
    cols = bitmap[0].size
    Size.new(cols, rows)
  end
end