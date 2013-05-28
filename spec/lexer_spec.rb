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
    lexer.tokenize.must_equal [ [:IDENTIFIER , 'time', 4] , [false, false, false] ]
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
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "A", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1],
                               [:WHITESPACE, " ", 1], [:NUMBER, "1", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "+", 1],
                               [:WHITESPACE, " ", 1], [:NUMBER, "2", 1], [:NEWLINE, "\n", 1], [:IDENTIFIER, "B", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "-", 1], [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], 
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "C", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1],
                               [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "*", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], [:NEWLINE, "\n", 1], [:IDENTIFIER, "D", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "/", 1], [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], 
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "E", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "&&", 2], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], [:NEWLINE, "\n", 1], [:IDENTIFIER, "F", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "%", 1], [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], 
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "G", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "<", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], [:NEWLINE, "\n", 1], [:IDENTIFIER, "H", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], [:WHITESPACE, " ", 1], [:NUMBER, "3", 1],
                               [:WHITESPACE, " ", 1], [:OPERATOR, ">", 1], [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], 
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "I", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "3", 1], [:WHITESPACE, " ", 1], [:OPERATOR, "%", 1], 
                               [:WHITESPACE, " ", 1], [:NUMBER, "4", 1], [:NEWLINE, "\n", 1], [:IDENTIFIER, "M", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, "==", 2], [:WHITESPACE, " ", 1], [:IDENTIFIER, "J", 1], 
                               [:NEWLINE, "\n", 1], [:IDENTIFIER, "echo", 4], [:WHITESPACE, " ", 1], [:IDENTIFIER, "A", 1], 
                               [:WHITESPACE, " ", 1], [:OPERATOR, ">", 1], [:WHITESPACE, " ", 1], [:IDENTIFIER, "B", 1], 
                               [:NEWLINE, "\n", 1], [false, false, false]
                              ]
  end
  

  it "should return an array of tokens for a statement" do
    lexer = lex "alias lsd = 'ls -app'"
    lexer.tokenize.must_equal [
                               [:ALIAS, "alias", 5], [:WHITESPACE, " ", 1], [:IDENTIFIER, "lsd", 3],
                               [:WHITESPACE, " ", 1], [:OPERATOR, "=", 1], [:WHITESPACE, " ", 1], 
                               [:STRING, "'ls -app'", 9], [false, false, false]
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
alias lsd = 'ls -A'
CODE
                )
    lexer.tokenize
    lexer.next_token.must_equal [:ALIAS, "alias", 5]
  end

end
