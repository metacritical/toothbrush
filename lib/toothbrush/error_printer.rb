module ToothBrush								
  module ErrorPrinter
    def error!(message)
      raise LexError, message rescue paint("#{$!.class}\n-> #{$!.message} :: #{getline position}(line)\n", :red);exit
    end
    
    def syntax_error!(message)
      raise SyntaxError , message rescue paint("#{$!.class}\n-> #{$!.message} :: '#{matched}' @ #{getline position}(line)\n", :red);exit
    end

    def parse_error!(message)
      raise ParseError , message rescue paint("#{$!.class}\n-> #{message} :: #{@lexer.position - 1}\n" , :red)
    end
  end
end
