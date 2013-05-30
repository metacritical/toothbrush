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
                               [:NEWLINE, "\n"], [:IDENTIFIER, "A"],  [:OPERATOR, "="],  [:NUMBER, "1"], 
                               [:OPERATOR, "+"], [:NUMBER, "2"], [:TERMINATOR , ";"] ,[:NEWLINE, "\n"], [:IDENTIFIER, "B"], 
                               [:OPERATOR, "="], [:NUMBER, "3"],  [:OPERATOR, "-"], [:NUMBER, "4"],[:TERMINATOR , ";"], 
                               [:NEWLINE, "\n"], [:IDENTIFIER, "C"],  [:OPERATOR, "="], [:NUMBER, "3"],
                               [:OPERATOR, "*"], [:NUMBER, "4"], [:TERMINATOR , ";"] ,[:NEWLINE, "\n"], [:IDENTIFIER, "D"],  [:OPERATOR, "="],  [:NUMBER, "3"],
                               [:OPERATOR, "/"], [:NUMBER, "4"], [:TERMINATOR , ";"] ,[:NEWLINE, "\n"], [:IDENTIFIER, "E"],
                               [:OPERATOR, "="], [:NUMBER, "3"],  [:OPERATOR, "&&"], [:NUMBER, "4"], [:TERMINATOR , ";"],
                               [:NEWLINE, "\n"], [:IDENTIFIER, "F"],  [:OPERATOR, "="], [:NUMBER, "3"],
                               [:OPERATOR, "%"], [:NUMBER, "4"], [:TERMINATOR , ";"] , [:NEWLINE, "\n"], [:IDENTIFIER, "G"], 
                               [:OPERATOR, "="], [:NUMBER, "3"], [:OPERATOR, "<"],  [:NUMBER, "4"], [:TERMINATOR , ";"],
                               [:NEWLINE, "\n"], [:IDENTIFIER, "H"], [:OPERATOR, "="],  [:NUMBER, "3"], 
                               [:OPERATOR, ">"], [:NUMBER, "4"], [:TERMINATOR , ";"] , [:NEWLINE, "\n"], [:IDENTIFIER, "I"],
                               [:OPERATOR, "="], [:NUMBER, "3"],  [:OPERATOR, "%"],  [:NUMBER, "4"], [:TERMINATOR , ";"] ,
                               [:NEWLINE, "\n"], [:IDENTIFIER, "M"],  [:OPERATOR, "=="],  [:IDENTIFIER, "J"], [:TERMINATOR , ";"],
                               [:NEWLINE, "\n"], [:IDENTIFIER, "echo"],  [:IDENTIFIER, "A"],  [:OPERATOR, ">"], 
                               [:IDENTIFIER, "B"],[:TERMINATOR , ";"], [:NEWLINE, "\n"], [false, false]
                              ]
                              
  end
  

  it "should return an array of tokens for a statement" do
    lexer = lex "alias lsd = 'ls -app'"
    lexer.tokenize.must_equal [
                               [:ALIAS, "alias"], [:IDENTIFIER, "lsd"],
                               [:OPERATOR, "="], [:STRING, "'ls -app'"], [false, false]
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
