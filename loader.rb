["../", "../lib"].each{ |dir| $LOAD_PATH << File.expand_path(dir,__FILE__) }

require 'bundler/setup'
require 'strscan'
require 'tools/color_printer'
require 'toothbrush'
require 'pp'

#Include Toplevel ToothBrush Module
include ToothBrush
include ColorPrinter
include ::ErrorPrinter

class Lexer
  include ::Tokens
  include ::Scanner
end
