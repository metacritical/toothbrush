task :test, [:arguments] => [:setup, :compile] do
  desc "Test task with environment Arguments"
  ['spec'].each{ |dir| $: << dir }
  Dir['spec/*_spec.rb'].each {|file| require File.basename(file , '.rb') }
end

task :setup , :arguments  do |taskname , params|
  desc "Setup environment task which test tasks depends upon"
  ENV["VERBOSE"]="true" if params[:arguments] == "verbose"
end

task :compile do |t|
  desc "Compile task for tb_grammar.y in src and output to lib parser.rb"
  puts "Grammar File Compiled" if system "racc -l -o lib/toothbrush/parser.rb src/grammar.y" 
end

task :debug_parser do |t|
  desc "Compile task for tb_grammar.y in src and output to lib parser.rb"
  system "racc -l -t -o lib/toothbrush/parser.rb src/grammar.y"
end

task :parser do |t|
  desc "Test Toothbrush Parser"
  system  "ruby -Ispec spec/parser_spec.rb"
end

desc "Run All Tasks"
task :all => [:test , :parser , :debug_parser]

desc "Compile grammar file"
task :compile

desc "Output Rake Debug Parser"
task :debug_parser

desc "Test Toothbrush Parser"
task :parser

desc "Run test Verbose Test aguments : verbose"
task :test , [:arguments]
