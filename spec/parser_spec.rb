require 'support/spec_helper'

describe Parser do 
  def parser(code , verbose=false)
    Parser.new.parse code , verbose
  end

  it "should out put an ast for following statements" do
    # @parser = parser "alias lsd = 123;" , true
     @parser = Parser.new
    # @parser.parse "" , true
    # @parser.parse ";" , true
    # @parser.parse "\n" , true
    # @parser.parse "alias" , true
     @parser.parse "alias;" , true
    # @parser.parse "alias\n" , true
    # @parser.parse "ls;" , true
    # @parser.parse "alias lsd = 'ls -a';" , true
    # @parser.parse "a" , true
    # @parser.parse "a = 1 + 2" , true
    # @parser.parse "a = 3 + 4 + 5 + 6;" , true
    @parser.parse "A=123" , true
    @parser.parse %Q{
hello:
  echo "hi world!"
} , true

  end
end






