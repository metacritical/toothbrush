class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING WHITESPACE INDENT TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION ALIAS

rule
        Root : ALIAS { puts "Found Just Alias #{val[0].intern}"}
             | ALIAS NEWLINE { puts "Found Alias Newline #{val[0].intern}"}
             ;


---- inner

attr_accessor :result

def lex(code)
@lexer = Lexer.new(code)
@lexer.tokenize #Kickstart lexer
end

def parse(code)
  lex(code)
  @result
  do_parse
end

def next_token
  @lexer.next_token
end

