module ToothBrush
  module Tokens
    KEYWORDS = %w(if alias)
    
    IDENTIFIER = %r|\w+|
    METHOD = %r|\w+\:|
    ASSIGNMENT = %r|\=|
    INDENT = %r|\s+|
    WHITESPACE = %r|([ \t]+)|
    SINGLE_QUOTE = %r|\'|
    DOUBLE_QUOTE = %r|\"|
    PARAMETERS = %r|\-\w+|

    def method_token
      parsed_tokens << [:METHOD , matched] if match(METHOD)
    end
    
    def identifier_token
      if match(IDENTIFIER) then 
        if KEYWORDS.include?(matched)
          parsed_tokens << [matched.upcase.intern, matched, matched_size]
        else
          parsed_tokens << [:IDENTIFIER, matched, matched_size]
        end
      end
    end
    
    def parameters_token
      parsed_tokens << [:PARAMETERS, matched, matched_size] if match(PARAMETERS)
    end
    
    def double_quote_token
      parsed_tokens << [:DOUBLE_QUOTE, matched, matched_size] if match(DOUBLE_QUOTE)
    end
    
    def single_quote_token
      parsed_tokens << [:SINGLE_QUOTE, matched, matched_size] if match(SINGLE_QUOTE)
    end

    def whitespace_token
      parsed_tokens << [:WHITESPACE, matched, matched_size] if match(WHITESPACE)
    end
    
    def indent_token
      parsed_tokens << [:INDENT, matched, matched_size] if match(INDENT) 
    end
    
    def assignment_token
      parsed_tokens << [:ASSIGNMENT, matched, matched_size] if match(ASSIGNMENT)
    end
  end
end
