module ToothBrush
  class Lexer
    attr_reader :parsed_tokens , :scanner
    
    KEYWORDS = %w(if alias)

    ASSIGNMENT = %r|\=|


    def initialize(input)
      @code = input
      @scanner = StringScanner.new input
      @parsed_tokens = []
    end

    def tokenize
      while not @scanner.eos?
        case
        when match(/\w+\:/)          then @parsed_tokens << [:METHOD , matched]
        when match(/\w+/)        then if KEYWORDS.include?(matched)
                                        @parsed_tokens << [matched.upcase.intern, matched]
                                      else
                                        @parsed_tokens << [:IDENTIFIER , matched]
                                      end
        when match(/\A([ \t]+)/)     then @parsed_tokens << [:WHITESPACE , matched_size]
        when match(/\A\n+\s+|\A\s+/) then @parsed_tokens << [:INDENT , matched_size]
        when match(ASSIGNMENT)       then @parsed_tokens << [:ASSIGNMENT , matched]
        when match(/\'/)             then @parsed_tokens << [:SINGLE_QUOTE , matched]
        when match(/\"/)             then @parsed_tokens << [:DOUBLE_QUOTE , matched]
        when match(/\-\w+/)          then @parsed_tokens << [:PARAMETERS , matched]
        end
      end
      @parsed_tokens << [false, false , false]
      code_inspect @parsed_tokens if ENV["VERBOSE"]
      @parsed_tokens
    end

    private
    def match regex
      @scanner.scan regex
    end
    
    def matched
      @scanner.matched
    end
    
    def matched_size
      @scanner.matched_size
    end



    def generate_token 
    end
  end
end
