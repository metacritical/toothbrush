class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING WHITESPACE INDENT 
toke TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION ALIAS ASSIGNMENT
token ADDITION SUBSTRACTION MULTIPLICATION DIVISION
  
rule
        Root : /* Empty String */ #Nothing to do though we might need to take some action eventually for  
             | Terminator { parse_error! "Unexpected Token Found '#{val[0]}'" }
             | Command { paint "Reached Command : #{val[0]}\n" , :cyan }
             | NEWLINE { paint "Reached NEWLINE : #{val[0]}\n" , :magenta }
             ;

  Terminator : TERMINATOR;
                 
     Command : Expression { paint "Reached Expression : #{val[0]}\n" , :yellow }
             | Expression Terminator { paint "Reached Expression Terminator : #{val[0]}\n" , :white }
             | Expression NEWLINE    { paint "Expression NEWLINE : #{val[0]} | #{val[1].inspect}\n" , :white }
             | Expression NEWLINE Terminator { paint "Expression NEWLINE Terminator : #{val[0]} | #{val[1].inspect} | #{val[2]}\n" , :red }
             ;

     Literal : NUMBER
             | IDENTIFIER
             | STRING
             ; 


  Expression : Alias
             | Literal
             | Assignment
             ;

       Alias : ALIAS
             | ALIAS Assignment
             ;

  Assignment : Expression Addition | Expression ASSIGNMENT Expression { paint "Assignment #{val[0]} | #{val[1]} | #{val[2]}\n" }
             ;

    Addition : NUMBER ADDITION NUMBER;



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
