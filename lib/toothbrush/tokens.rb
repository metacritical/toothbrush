module ToothBrush
  module Tokens
    KEYWORDS = %w(if alias do else while when then case builtin)
    RESERVED_WORDS = %w(function declare readonly)
        
    CONSTANT = %r|^\A\w+|
    IDENTIFIER = %r|\w+|
    FUNCTION = %r|\w+\:|
    INDENT = %r|\s+|
    WHITESPACE = %r|([ \t]+)|
    STRING = %r_""|''|"(.*?)"|'(.*?)'_
    PARAMETERS = %r|\-\w+|
    NUMBER = %r_[0-9]+|[0-9]+.[0-9]+_
    OPERATOR = %r_([+\*&|\/\-%=<>:!?]+)_
    TERMINATOR = %r|\;+|

    def function_token
      parsed_tokens << [:FUNCTION , matched] if match(FUNCTION)
    end

    def constant_token
      parsed_tokens << [:CONSTANT , matched] if match(CONSTANT)
    end


    def identifier_token
      if match(IDENTIFIER) then 
        syntax_error! "Syntax Error : Invalid usage of reserved keywords" if RESERVED_WORDS.include?(matched)
        if KEYWORDS.include?(matched)
          parsed_tokens << [matched.upcase.intern, matched]
        else
          parsed_tokens << [:IDENTIFIER, matched]
        end
      end
    end
    
    def parameters_token
      parsed_tokens << [:PARAMETERS, matched] if match(PARAMETERS)
    end
    
    def string_token
      parsed_tokens << [:STRING, matched] if match(STRING)
    end
    
    def whitespace_token
      true if match(WHITESPACE)
    end
    
    def indent_token
      sanitize_indent_or_newline if match(INDENT)
    end

    def terminator_token
      sanitize_indent_or_newline if match(TERMINATOR)
    end
    
    def sanitize_indent_or_newline
      slice_result = matched.slice(/[^(\n)]+/)
      unless slice_result.nil?
        return parsed_tokens << [:TERMINATOR , slice_result] if slice_result =~ TERMINATOR
        return parsed_tokens << [:INDENT, slice_result] if slice_result =~ WHITESPACE
      else
        parsed_tokens << [:NEWLINE, "\n"] unless previous_token == :NEWLINE
      end
    end

    def operator_token
      if match(OPERATOR)
        case matched
        when '=' then parsed_tokens << [:ASSIGNMENT , matched]
        when '+' then parsed_tokens << [:ADDITION, matched]
        when '-' then parsed_tokens << [:SUBSTRACTION, matched]
        when '*' then parsed_tokens << [:MULTIPLICATION, matched]              
        when '/' then parsed_tokens << [:DIVISION, matched]
        else
          parsed_tokens << [:OPERATOR, matched]
        end
      end
    end

    def number_token
      parsed_tokens << [:NUMBER, matched] if match(NUMBER)
    end

    def previous_token
      parsed_tokens.last && parsed_tokens.last[0]
    end

    def next_token
      parsed_tokens.shift unless parsed_tokens.empty?
    end

  end
end
