# I M N: init M columns and N rows
# C: clear
# L X Y C
# V X Y1 Y2 C
# H X1 X2 V C
# S: Show
# https://gist.github.com/soulnafein/8ee4e60def4e5468df2f
# https://github.com/carwow/bitmap_editor/blob/master/app/bitmap_editor.rb
# template = %{
#   I 5 6
#   L 2 3 A
#   S
# }.strip.split("\n").map(&:strip)

def init m, n
  (1..n).map{ (1..m).map{ ?O } }
end

def clear bitmap
  rows = bitmap.size
  cols = bitmap[0].size
  init cols, rows
end

def show bitmap, &block
  str = bitmap.map(&:join).join("\n")
  block_given? ? (yield str) : (puts str)
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