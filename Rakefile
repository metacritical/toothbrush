task :test, [:arguments] => [:setup, :compile] do
  desc "Test task with environment Arguments"
  ['spec', 'support'].each{ |dir| $: << dir }
  Dir['spec/*_spec.rb'].each {|file| require File.basename(file , '.rb') }
end

task :setup , :arguments  do |taskname , params|
  desc "Setup environment task which test tasks depends upon"
  ENV["VERBOSE"]="true" if params[:arguments] == "verbose"
end

task :compile do |t|
  desc "Compile task for tb_grammar.y in src and output to lib parser.rb"
  system "racc -l -o lib/toothbrush/parser.rb src/grammar.y"
end
