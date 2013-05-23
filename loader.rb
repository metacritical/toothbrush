["../", "../lib"].each{ |dir| $LOAD_PATH << File.expand_path(dir,__FILE__) }

require 'bundler/setup'
require 'strscan'
require 'tools/color_printer'
require 'toothbrush'

#Include Toplevel ToothBrush Module
include ToothBrush
include ColorPrinter
