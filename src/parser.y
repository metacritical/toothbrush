class ToothBrush::Parser
rule
      string : a_or_cs abb | abb { puts "Found Abb!" };
     a_or_cs : a_or_cs a_or_c | a_or_c;
      a_or_c : 'a' | 'c';
         abb : 'a' 'b' 'b';


---- inner

attr_accessor :result

def parse(str)

end


end
