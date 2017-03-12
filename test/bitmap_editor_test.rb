require 'minitest/autorun'
require_relative '../app/bitmap_editor'
require_relative '../app/commands'

editor = BitmapEditor.new

describe("BitmapEditor#parse") do
  it "should parse `S` commands" do
    editor.parse('S').must_equal(Commands::Show)
  end
  it "should parse `C` commands" do
    editor.parse('C').must_equal(Commands::Clear)
  end
  it "should parse `I` commands" do
    editor.parse('I 4 2').must_be_instance_of Commands::Init
    editor.parse('I 123 2').must_be_instance_of Commands::Init
    editor.parse('I 1 234').must_be_instance_of Commands::Init
    editor.parse('I 123 456').must_be_instance_of Commands::Init
  end
  it "should parse `L` commands" do
    editor.parse('L 4 2 X').must_be_instance_of Commands::Color
    editor.parse('L 1234 5 F').must_be_instance_of Commands::Color
  end
  it "should parse `H` commands" do
    editor.parse('H 2 4 2 X').must_be_instance_of Commands::Horizontal
    # negative x1 x2 range
    editor.parse('H 5 1 2 X').must_be_instance_of Commands::Horizontal
  end
  it "should parse `V` commands" do
    editor.parse('V 2 1 5 X').must_be_instance_of Commands::Vertical
    # negative y1 y2 range
    editor.parse('V 2 5 1 X').must_be_instance_of Commands::Vertical
  end
  it "does not support white spaces in front or after the command" do
    valid_command = 'L 2 2 F'
    editor.parse(valid_command).must_be_instance_of Commands::Color
    editor.parse("#{valid_command} ").must_equal Commands::Unknown
    editor.parse(" #{valid_command}").must_equal Commands::Unknown
  end
  it "should handle unknown commands" do
    editor.parse('NOT IMPLEMENTED').must_equal Commands::Unknown
  end
end
