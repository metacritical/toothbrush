class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING WHITESPACE INDENT TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION ALIAS false
  
rule
        Root : /* Empty String */ #Nothing to do though we might need to take some action eventually for  
             | ALIAS { p "Found Just Alias : #{val[0]}"}
             | ALIAS NEWLINE { p "Found Alias Newline : " + val[1]}
             | ALIAS TERMINATOR {p "Found Alias with Terminator : #{val[0]}  #{val[1]}" }
             | Declaration { p "Found only declaration : #{val[0]}" }
             | Terminator
             ;

  Terminator : NEWLINE 
             | TERMINATOR { parse_error! "Unexpected Token Found '#{val[0]}'" }
             ;

    Addition : NUMBER OPERATOR NUMBER;

 Declaration : IDENTIFIER OPERATOR Addition { p "Found Identifier Operator Expr : #{val[0]} #{val[1]} #{val[2]}" }
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
