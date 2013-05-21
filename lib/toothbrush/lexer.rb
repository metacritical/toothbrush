module ToothBrush
  class Lexer
    def initialize(input)
      @code = input.chomp
      @scanner = StringScanner.new @code
      @parsed_tokens = []
    end

    def tokenize
      @parsed_tokens
    end
  end
end
