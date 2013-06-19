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
    
    lexer.tokenize.must_equal([
                               [:CONSTANT, "A"], [:ASSIGNMENT, "="], [:NUMBER, "1"], [:ADDITION, "+"], [:NUMBER, "2"], 
                               [:TERMINATOR, ";"], [:CONSTANT, "B"], [:ASSIGNMENT, "="], [:NUMBER, "3"], [:SUBSTRACTION, "-"], 
                               [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "C"], [:ASSIGNMENT, "="], [:NUMBER, "3"], 
                               [:MULTIPLICATION, "*"], [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "D"], [:ASSIGNMENT, "="], 
                               [:NUMBER, "3"], [:DIVISION, "/"], [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "E"], 
                               [:ASSIGNMENT, "="], [:NUMBER, "3"], [:OPERATOR, "&&"], [:NUMBER, "4"], [:TERMINATOR, ";"], 
                               [:CONSTANT, "F"], [:ASSIGNMENT, "="], [:NUMBER, "3"], [:OPERATOR, "%"], [:NUMBER, "4"], 
                               [:TERMINATOR, ";"], [:CONSTANT, "G"], [:ASSIGNMENT, "="], [:NUMBER, "3"], [:OPERATOR, "<"], 
                               [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "H"], [:ASSIGNMENT, "="], [:NUMBER, "3"], 
                               [:OPERATOR, ">"], [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "I"], [:ASSIGNMENT, "="], 
                               [:NUMBER, "3"], [:OPERATOR, "%"], [:NUMBER, "4"], [:TERMINATOR, ";"], [:CONSTANT, "M"], 
                               [:OPERATOR, "=="], [:CONSTANT, "J"], [:TERMINATOR, ";"], [:IDENTIFIER, "echo"], [:CONSTANT, "A"], 
                               [:OPERATOR, ">"], [:CONSTANT, "B"], [:TERMINATOR, ";"], [false, false]
                              ])
  end
  

  it "should return an array of tokens for a statement" do
    lexer = lex "alias lsd = 'ls -app'"
    lexer.tokenize.must_equal [
     [:ALIAS, "alias"], [:IDENTIFIER, "lsd"],
     [:ASSIGNMENT, "="], [:STRING, "'ls -app'"], [false, false]
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
