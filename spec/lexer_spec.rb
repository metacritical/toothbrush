require './support/spec_helper'

describe Lexer do 
  def lexer_instance(code)
    @lexer = Lexer.new code
  end

  it "should return empty array for empty string" do
    code = ""
    lexer_instance code
    @lexer.tokenize.must_be_empty
  end
end


