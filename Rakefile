task :test do
  ['spec', 'support'].each{ |dir| $: << dir }
  Dir.glob('spec/*_spec.rb') {|file| require File.basename(file , '.rb') }
end	 			 
