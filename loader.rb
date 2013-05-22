["../lib", "../tools"].each{ |dir| $LOAD_PATH << File.expand_path(dir,__FILE__) }

require 'bundler/setup'
require 'strscan'
require 'color_printer'
require 'toothbrush'

#Include Toplevel ToothBrush Module
include ToothBrush
include ToothBrush::ColorPrinter
