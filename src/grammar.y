class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING INDENT DEDENT CONSTANT
token TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION ALIAS ASSIGNMENT
token ADDITION SUBSTRACTION MULTIPLICATION DIVISION

rule
        Root : /* Empty String */ { paint "| Empty String |" , :white}
             | Terminator { paint "0) Terminator or Newline Found '#{val[0]}'\n" }
             | Command  { paint "1) Reached Command : #{val[0]}\n" , :cyan }
             | Command Terminator { paint "2) Expression Terminator : #{val[0]} | #{val[1].inspect} | #{val[2]}\n", :red }
             ;

  Terminator : TERMINATOR 
             | NEWLINE 
             ;
                 
     Command : Expression { paint "3) Reached Expression : #{val[0]}\n" , :yellow }
             ;

  Expression : Declaration
             | Assignment
             | Addition
             | Literal
             ;

 Declaration : Alias
             | Declaration Literal ASSIGNMENT Literal { paint "4) Declaration : #{val[0]} | #{val[1]} | #{val[2]} | #{val[3]}\n" , :blue }
             ;

       Alias : ALIAS
             ;

     Literal : IDENTIFIER
             | STRING
             | NUMBER
             | CONSTANT
             ; 


  Assignment : Literal ASSIGNMENT Expression { paint "Assignment #{val[0]} | #{val[1]} | #{val[2]}\n" };
                 
    Addition : Literal ADDITION Expression { paint "Addition #{val[0]} | #{val[1]} | #{val[2]}\n" };

---- inner

attr_accessor :result

  def lex(code)
    @lexer = Lexer.new(code)
    @lexer.tokenize #Kickstart lexer
  end

  def parse(code,verbose=false)
    lex(code)
    @result
    code_inspect @lexer if verbose
    do_parse
  end

  def next_token
    @lexer.next_token 
  end
