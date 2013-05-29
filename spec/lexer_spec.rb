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
    lexer.tokenize.must_equal [ [false, false] ]
  end

  it "should return basic tokens for input string" do
    lexer = lex "time"
    lexer.tokenize.must_equal [ [:IDENTIFIER , 'time'] , [false, false] ]
  end

  it "should lex expressions" do
    lexer = lex %Q{
A = 1 + 2;
B = 3 - 4;
C = 3 * 4;
D = 3 / 4;
E = 3 && 4;
F = 3 % 4;
G = 3 < 4;
H = 3 > 4;
I = 3 % 4;
M == J;
echo A > B;
}
    
    lexer.tokenize.must_equal [
[:NEWLINE, "\n"], [:IDENTIFIER, "A"], [:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "1"], 
[:WHITESPACE, " "], [:OPERATOR, "+"], [:WHITESPACE, " "], [:NUMBER, "2"], [:NEWLINE, "\n"], [:IDENTIFIER, "B"], 
[:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, "-"], 
[:WHITESPACE, " "], [:NUMBER, "4"], [:NEWLINE, "\n"], [:IDENTIFIER, "C"], [:WHITESPACE, " "], [:OPERATOR, "="], 
[:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, "*"], [:WHITESPACE, " "], [:NUMBER, "4"], 
[:NEWLINE, "\n"], [:IDENTIFIER, "D"], [:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "3"],
[:WHITESPACE, " "], [:OPERATOR, "/"], [:WHITESPACE, " "], [:NUMBER, "4"], [:NEWLINE, "\n"], [:IDENTIFIER, "E"],
[:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, "&&"],
[:WHITESPACE, " "], [:NUMBER, "4"], [:NEWLINE, "\n"], [:IDENTIFIER, "F"], [:WHITESPACE, " "], [:OPERATOR, "="],
[:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, "%"], [:WHITESPACE, " "], [:NUMBER, "4"],
[:NEWLINE, "\n"], [:IDENTIFIER, "G"], [:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "3"],
[:WHITESPACE, " "], [:OPERATOR, "<"], [:WHITESPACE, " "], [:NUMBER, "4"], [:NEWLINE, "\n"], [:IDENTIFIER, "H"], 
[:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, ">"], 
[:WHITESPACE, " "], [:NUMBER, "4"], [:NEWLINE, "\n"], [:IDENTIFIER, "I"], [:WHITESPACE, " "], [:OPERATOR, "="], 
[:WHITESPACE, " "], [:NUMBER, "3"], [:WHITESPACE, " "], [:OPERATOR, "%"], [:WHITESPACE, " "], [:NUMBER, "4"], 
[:NEWLINE, "\n"], [:IDENTIFIER, "M"], [:WHITESPACE, " "], [:OPERATOR, "=="], [:WHITESPACE, " "], [:IDENTIFIER, "J"], 
[:NEWLINE, "\n"], [:IDENTIFIER, "echo"], [:WHITESPACE, " "], [:IDENTIFIER, "A"], [:WHITESPACE, " "], [:OPERATOR, ">"], 
[:WHITESPACE, " "], [:IDENTIFIER, "B"], [:NEWLINE, "\n"], [false, false]
]
                              
  end
  

  it "should return an array of tokens for a statement" do
    lexer = lex "alias lsd = 'ls -app'"
    lexer.tokenize.must_equal [
                               [:ALIAS, "alias"], [:WHITESPACE, " "], [:IDENTIFIER, "lsd"],
                               [:WHITESPACE, " "], [:OPERATOR, "="], [:WHITESPACE, " "], 
                               [:STRING, "'ls -app'"], [false, false]
                              ]

  end

  it "should be able recognize a method block" do
    lexer = lex(
          <<CODE
runner:

  echo "hi";


CODE
)
    lexer.tokenize
  end

  it "Should be able to call next_token on lexer" do
    lexer = lex(<<CODE
alias lsd = 'ls -A';
CODE
                )
    lexer.tokenize
    lexer.next_token.must_equal [:ALIAS, "alias"]
  end

end
