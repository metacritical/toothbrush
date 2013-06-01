class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING WHITESPACE INDENT 
token TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION ALIAS ASSIGNMENT
token ADDITION SUBSTRACTION MULTIPLICATION DIVISION
  
rule
        Root : /* Empty String */ #Nothing to do though we might need to take some action eventually for  
             | Terminator { parse_error! "Unexpected Token Found '#{val[0]}'\n" }
             | NEWLINE { paint "1) Reached NEWLINE : #{val[0].inspect}\n" , :magenta }
             | Command { paint "2) Reached Command : #{val[0]}\n" , :cyan }
             ;

  Terminator : TERMINATOR;
                 
     Command : Expression { paint "3) Reached Expression : #{val[0]}\n" , :yellow }
             | Expression NEWLINE    { paint "4) Expression NEWLINE : #{val[0]} | #{val[1].inspect}\n" , :white} 
             | Expression Terminator { paint "Reached Expression Terminator : #{val[0]} #{val[1]}\n" , :white }
             | Expression NEWLINE Terminator { paint "5) Expression NEWLINE Terminator : #{val[0]} | #{val[1].inspect} | #{val[2]}\n", :red }
             ;

  Expression : Declaration
             | Literal 
             | Assignment
             | Addition
             ;

 Declaration : Alias 
             | Declaration Literal ASSIGNMENT Literal { paint "6) Declaration : #{val[0]} | #{val[1]} | #{val[2]} | #{val[3]}\n" , :blue }
             ;

       Alias : ALIAS
             ;

     Literal : IDENTIFIER
             | STRING
             | NUMBER
             ; 

   Assignment : Literal ASSIGNMENT Expression { paint "Assignment #{val[0]} | #{val[1]} | #{val[2]}\n" }
                 
    Addition : Literal ADDITION Expression { paint "Addition #{val[0]} | #{val[1]} | #{val[2]}\n" };



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
