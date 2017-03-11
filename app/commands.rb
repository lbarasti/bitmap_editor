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
  range = (y1 - 1..y2 - 1)
  bitmap.map.with_index{|row, i| range.include?(i) ?
    row.map.with_index{|v, j| j == (x - 1) ? c : v} : row}
end

# def t bitmap
#   transposed = init bitmap.size, bitmap[0].size
#   bitmap.each.with_index{|row, i| row.each.with_index{|v, j| transposed[j][i] = v}}
#   transposed
# end