require 'minitest/autorun'
require_relative '../app/commands'
include Commands

bitmap = [[?A, ?B, ?O],
          [?O, ?O, ?A]]

describe("C") do
  it "should return an empty bitmap with the size of the given one" do
    Clear.(bitmap).must_equal([[?O,?O,?O],[?O,?O,?O]])
  end
end

describe("S") do
  it "should return the given bitmap" do
    Show.(bitmap).must_equal(bitmap)
  end
end

describe("Init") do
  it "should return the identity lambda if the coordinates are out of bound" do
    max_x, max_y = 3, 5
    Init.new(0, 1, max_x, max_y).(bitmap).must_equal bitmap
    Init.new(1, -1, max_x, max_y).(bitmap).must_equal bitmap
    Init.new(max_x + 1, 1, max_x, max_y).(bitmap).must_equal bitmap
    Init.new(1, max_y + 1, max_x, max_y).(bitmap).must_equal bitmap
    Init.new(max_x + 1, max_y + 1, max_x, max_y).(bitmap).must_equal bitmap
  end
  it "should return a new bitmap if the coordinates are valid" do
    empty_bitmap = [[?O,?O,?O,?O],
                    [?O,?O,?O,?O],
                    [?O,?O,?O,?O]]
    max_x, max_y = 4, 3
    x, y = max_x, max_y
    Init.new(x, y, max_x, max_y).(bitmap).must_equal empty_bitmap
  end
end

describe("Color") do
  it "should return the identity lambda if the coordinates are out of bound" do
    x, y = 3, 2
    Color.new(x + 1, y, ?F).(bitmap).must_equal bitmap
    Color.new(x, y + 1, ?F).(bitmap).must_equal bitmap
    Color.new(0, y, ?F).(bitmap).must_equal bitmap
    Color.new(x, 0, ?F).(bitmap).must_equal bitmap
  end
  it "should color the given cell if the coordinates are valid" do
    Color.new(1, 2, ?F).(bitmap).must_equal [[?A, ?B, ?O], [?F, ?O, ?A]]
  end
end

describe("Horizontal") do
  it "should return the identity lambda if the coordinates are out of bound" do
    x, y = 3, 2
    Horizontal.new(x, x + 1, y, ?F).(bitmap).must_equal bitmap
    Horizontal.new(x - 1, x, y + 1, ?F).(bitmap).must_equal bitmap
    Horizontal.new(0, x, y, ?F).(bitmap).must_equal bitmap
    Horizontal.new(x - 1, x, 0, ?F).(bitmap).must_equal bitmap
  end
  it "should color the given row if the coordinates are valid" do
    Horizontal.new(1, 3, 2, ?F).(bitmap).must_equal [[?A, ?B, ?O], [?F, ?F, ?F]]
  end
end

describe("Vertical") do
  it "should return the identity lambda if the coordinates are out of bound" do
    x, y = 3, 2
    Vertical.new(x, y, y + 1, ?F).(bitmap).must_equal bitmap
    Vertical.new(x + 1, y - 1, y, ?F).(bitmap).must_equal bitmap
    Vertical.new(0, y - 1, y, ?F).(bitmap).must_equal bitmap
    Vertical.new(x, 0, y - 1, ?F).(bitmap).must_equal bitmap
  end
  it "should color the given column if the coordinates are valid" do
    Vertical.new(3, 1, 2, ?F).(bitmap).must_equal [[?A, ?B, ?F], [?O, ?O, ?F]]
  end
end

describe("Unknown") do
  it "should return the given bitmap" do
    Unknown.(bitmap).must_equal(bitmap)
  end
end
