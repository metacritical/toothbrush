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
      parsed_tokens << [false, false , false]
      code_inspect parsed_tokens if ENV["VERBOSE"]
      parsed_tokens
    end

    def error!(message)
      raise LexError, message rescue paint("#{$!.class}\n-> #{$!.message} :: #{getline position}(line)\n", :red);exit
    end

    def generate_token
      case
      when method_token
      when identifier_token
      when whitespace_token
      when indent_token
      when assignment_token
      when single_quote_token
      when double_quote_token
      when parameters_token
      else
        error! "Invalid Token : '#{scanner.check /.*/}' -> #{position}(char)"
      end
    end
  end
end
