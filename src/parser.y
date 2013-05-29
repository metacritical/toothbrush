class ToothBrush::Parser
token IDENTIFIER PARAMETERS STRING WHITESPACE INDENT TERMINATOR NEWLINE NUMBER OPERATOR FUNCTION

rule
        Root : '#' { result = Expressions.new }
             | Terminator { result = Expressions.new }
             | Expressions { result = Expressions.new }
             ;


  Terminator : "\n"
             | ";"
             ;

 Expressions : Identifier 
             | Function
             ;

  Identifier : IDENTIFIER;

    Function : FUNCTION;




---- inner

attr_accessor :result

def parse(str)
  @result
  do_parse
end


end
