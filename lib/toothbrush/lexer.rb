module ToothBrush
  class Lexer
    attr_reader :parsed_tokens , :scanner , :code
    
    def initialize(input)
      @code = input
      @scanner = StringScanner.new input
      @parsed_tokens = []
    end

    def tokenize
      while not @scanner.eos?
        generate_token
      end
      parsed_tokens << [false, false]
      code_inspect parsed_tokens if ENV["VERBOSE"]
      parsed_tokens 
    end

    def generate_token
      case
      when function_token
      when number_token
      when parameters_token
      when operator_token
      when identifier_token
      when whitespace_token
      when indent_token
      when terminator_token
      when string_token
      else
        error! "Invalid Token : '#{scanner.check /.+?/}' -> #{position}(char)"
      end
    end
  end
end
