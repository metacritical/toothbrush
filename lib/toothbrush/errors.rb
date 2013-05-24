module ToothBrush
  class ToothBrushError < StandardError
  end
  
  class SyntaxError < ToothBrushError
  end

  class LexError < ToothBrushError
  end
  
  class ParseError < SyntaxError
  end
end
