#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'
module ToothBrush
  class Parser < Racc::Parser


attr_accessor :result

  def lex(code)
    @lexer = Lexer.new(code)
    @lexer.tokenize #Kickstart lexer
  end

  def parse(code)
    lex(code)
    @result
    do_parse
  end

  def next_token
    @lexer.next_token 
  end
##### State transition tables begin ###

racc_action_table = [
     7,    10,     9,    13,    11,     6,     5,    12,     8,    15,
     2,    16,    17,    18 ]

racc_action_check = [
     0,     2,     2,    11,     7,     0,     0,     8,     1,    13,
     0,    14,    15,    16 ]

racc_action_pointer = [
    -2,     8,    -6,   nil,   nil,   nil,   nil,    -9,     7,   nil,
   nil,    -6,   nil,    -5,    -3,     3,     4,   nil,   nil ]

racc_action_default = [
    -1,   -12,    -2,    -5,    -6,    -7,    -8,   -12,   -12,    -3,
    -4,   -12,    19,   -12,   -11,   -12,   -12,    -9,   -10 ]

racc_goto_table = [
     1,     3,     4,    14 ]

racc_goto_check = [
     1,     2,     3,     4 ]

racc_goto_pointer = [
   nil,     0,     1,     2,    -8 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 19, :_reduce_none,
  1, 19, :_reduce_2,
  2, 19, :_reduce_3,
  2, 19, :_reduce_4,
  1, 19, :_reduce_5,
  1, 19, :_reduce_none,
  1, 21, :_reduce_none,
  1, 21, :_reduce_8,
  3, 22, :_reduce_9,
  3, 22, :_reduce_10,
  3, 20, :_reduce_11 ]

racc_reduce_n = 12

racc_shift_n = 19

racc_token_table = {
  false => 0,
  :error => 1,
  :IDENTIFIER => 2,
  :PARAMETERS => 3,
  :STRING => 4,
  :WHITESPACE => 5,
  :INDENT => 6,
  :TERMINATOR => 7,
  :NEWLINE => 8,
  :NUMBER => 9,
  :OPERATOR => 10,
  :FUNCTION => 11,
  :ALIAS => 12,
  :ASSIGNMENT => 13,
  :ADDITION => 14,
  :SUBSTRACTION => 15,
  :MULTIPLICATION => 16,
  :DIVISION => 17 }

racc_nt_base = 18

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "IDENTIFIER",
  "PARAMETERS",
  "STRING",
  "WHITESPACE",
  "INDENT",
  "TERMINATOR",
  "NEWLINE",
  "NUMBER",
  "OPERATOR",
  "FUNCTION",
  "ALIAS",
  "ASSIGNMENT",
  "ADDITION",
  "SUBSTRACTION",
  "MULTIPLICATION",
  "DIVISION",
  "$start",
  "Root",
  "Declaration",
  "Terminator",
  "Arithmetic" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

def _reduce_2(val, _values, result)
 p "Found Just Alias : #{val[0]}"
    result
end

def _reduce_3(val, _values, result)
 p "Found Alias Newline : " + val[1]
    result
end

def _reduce_4(val, _values, result)
p "Found Alias with Terminator : #{val[0]}  #{val[1]}" 
    result
end

def _reduce_5(val, _values, result)
 p "Found only declaration : #{val[0]}" 
    result
end

# reduce 6 omitted

# reduce 7 omitted

def _reduce_8(val, _values, result)
 parse_error! "Unexpected Token Found '#{val[0]}'" 
    result
end

def _reduce_9(val, _values, result)
 p "Addition in bash : $((#{val[0]} #{val[1]} #{val[2]}))" 
    result
end

def _reduce_10(val, _values, result)
 p "Addition in bash : $((#{val[0]} #{val[1]} #{val[2]}))" 
    result
end

def _reduce_11(val, _values, result)
 p "Found Identifier Operator Expr : #{val[0]} #{val[1]} #{val[2]}" 
    result
end

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module ToothBrush
