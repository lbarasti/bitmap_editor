require 'minitest/autorun'
require_relative '../app/bitmap'

empty_bitmap = [[?O,?O,?O],
                [?O,?O,?O]]
bitmap = [[?A, ?B, ?O],
          [?O, ?O, ?A]]

describe("Init bitmab") do
  it "should return an empty bitmap with the give size" do
    init(3, 2).must_equal empty_bitmap
  end
end

describe("clear bitmap") do
  it "should clear an existing bitmap by setting all cells to 'O'" do
    clear(bitmap).must_equal empty_bitmap
  end
end

describe("bitmap's string representation") do
  it "should represent a bitmap as a 2D array" do
    to_string(bitmap).must_equal "ABO\nOOA"
  end
end

describe("color bitmap cell") do
  it "should color a specific cell with the given color" do
    color(bitmap, 2, 1, ?X)
      .must_equal [[?A,?X,?O],
                   [?O,?O,?A]]

    color(bitmap, 1, 1, ?X)
      .must_equal [[?X,?B,?O],
                   [?O,?O,?A]]

    color(bitmap, 2, 2, ?X)
      .must_equal [[?A,?B,?O],
                   [?O,?X,?A]]
  end
end

describe("color bitmap row") do
  it "should color a range in a row with the given color" do
    row(bitmap, 1, 2, 2, ?X)
      .must_equal [[?A,?B,?O],
                   [?X,?X,?A]]
  end
end

describe("color bitmap col") do
  it "should color a range in a col with the given color" do
    col(bitmap, 1, 1, 2, ?X)
      .must_equal [[?X,?B,?O],
                   [?X,?O,?A]]
  end
end

describe("composing commands") do
  it "should work on a newly instantiated bitmap" do
    [init(3,2)]
      .map{|bm| color(bm, 1, 1, ?X)
        .tap{ |bm| bm.must_equal [[?X, ?O, ?O],
                                  [?O, ?O, ?O]]}}
      .map{|bm| row(bm, 1, 3, 2, ?Y)
        .tap{ |bm| bm.must_equal [[?X, ?O, ?O],
                                  [?Y, ?Y, ?Y]]}}
      .map{|bm| col(bm, 2, 1, 2, ?W)
        .tap{ |bm| bm.must_equal [[?X, ?W, ?O],
                                  [?Y, ?W, ?Y]]}}
      .map{|bm| color(bm, 3, 2, ?K)
        .tap{ |bm| bm.must_equal [[?X, ?W, ?O],
                                  [?Y, ?W, ?K]]}}
      .map{|bm| clear(bm).must_equal empty_bitmap}
  end
end
