module ToothBrush
  class Lexer
    def initialize(input)
      @scanner = StringScanner.new input
      @parsed_tokens = []
    end

    def tokenize
      @parsed_tokens
    end
  end
end
