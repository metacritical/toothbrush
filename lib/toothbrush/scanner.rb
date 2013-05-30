module ToothBrush
  module Scanner
    def	match regex
      scanner.scan regex
    end
    
    def matched
      scanner.matched
    end
    
    def matched_size
      scanner.matched_size
    end
    
    def position
      scanner.pos.next
    end
    
    def getline(character)
      count = 0
      code.lines.each_with_index do |each,index|
        index.zero? ? count = each.size : count = count + each.size
        if count >= character
          return index + 1
        end  
      end  
    end
  end
end
