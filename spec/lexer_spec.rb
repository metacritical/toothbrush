require 'support/spec_helper'

describe Lexer do 
  def lex(code)
    Lexer.new code
  end

  it "should respond to tokenize method" do
    lexer = lex ""
    lexer.must_respond_to :tokenize
  end

  it "should return array with false" do
    lexer = lex ""
    lexer.tokenize.must_equal [ [false, false, false] ]
  end

  it "should return basic tokens for input string" do
    lexer = lex "time"
    lexer.tokenize.must_equal [ [:IDENTIFIER , 'time'] , [false, false, false] ]
  end

  it "should return an array of tokens for a statement" do
    lexer = lex "alias lsd  = 'ls -app'"
    lexer.tokenize.must_equal [
                   [:ALIAS, "alias"], [:WHITESPACE, 1], [:IDENTIFIER, "lsd"], 
                   [:WHITESPACE, 2], [:ASSIGNMENT, "="], [:WHITESPACE, 1], 
                   [:SINGLE_QUOTE, "'"], [:IDENTIFIER, "ls"], [:WHITESPACE, 1], 
                   [:PARAMETERS, "-app"], [:SINGLE_QUOTE, "'"], [false, false, false]
                  ]
  end

  it "should be able recognize a method block" do
    lexer = lex(
          <<CODE
runner:
  echo "hi"
CODE
                )
    lexer.tokenize
  end


  

end
